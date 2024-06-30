import SwiftUI
import HealthKit

// HealthKitManager to handle HealthKit logic
class HealthKitManager: ObservableObject {
    private var healthStore = HKHealthStore()
    
    @Published var todayData: [String: Double] = [:]
    
    func requestAuthorization(user: User) {
        let stepType = HKQuantityType.quantityType(forIdentifier: .stepCount)!
        let walkingRunningDistType = HKQuantityType.quantityType(forIdentifier: .distanceWalkingRunning)!
        let typesToRead: Set = [stepType, walkingRunningDistType]
        
        healthStore.requestAuthorization(toShare: [], read: typesToRead) { success, error in
            if success {
                self.fetchStepsPerDay() { stepData in
                    user.steps = stepData.sorted(by: {
                        $0.date < $1.date
                    })
                    user.onboardingStep += 1
                }
            } else {
                user.authenticatedHealthKit = false
            }
        }
    }
    
    func observeQuantity(quantity: HKQuantityTypeIdentifier, completion: @escaping (Double) -> ()){
        guard let quantityType = HKQuantityType.quantityType(forIdentifier: quantity) else { return }
        
        let query = HKObserverQuery(sampleType: quantityType, predicate: nil) { (query, completionHandler, errorOrNil) in
            
            if errorOrNil != nil {
                return
            }
            
            self.fetchQuantityToday(quantity: quantity, completion: completion)
            completionHandler()
        }
    }
    
    func fetchQuantityToday(quantity: HKQuantityTypeIdentifier, completion: @escaping (Double) -> ()) {
        guard let stepType = HKQuantityType.quantityType(forIdentifier: quantity) else { return }
        
        let calendar = Calendar.current
        let startOfDay = calendar.startOfDay(for: Date())
        let now = Date()
        
        let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: now, options: .strictStartDate)
        
        let query = HKStatisticsQuery(quantityType: stepType, quantitySamplePredicate: predicate, options: .cumulativeSum) { _, result, error in
            guard let result = result, let sum = result.sumQuantity() else {
                print("Failed to fetch steps: \(String(describing: error))")
                return
            }
            var data: Double = 0
            
            if quantity == .stepCount {
                data = sum.doubleValue(for: HKUnit.count())
            } else if quantity == .distanceWalkingRunning {
                data = sum.doubleValue(for: HKUnit.mile())
            }
            
            DispatchQueue.main.async {
                completion(data)
            }
        }
        
        healthStore.execute(query)
    }

    
    func fetchStepsPerDay(completion: @escaping ([StepData]) -> ()) {
            guard let stepType = HKQuantityType.quantityType(forIdentifier: .stepCount) else { return }
            
            let calendar = Calendar.current
            let now = Date()
            let startDate = Date.distantPast
            let interval = DateComponents(day: 1)
            
            let predicate = HKQuery.predicateForSamples(withStart: startDate, end: now, options: .strictEndDate)
            
            var anchorComponents = calendar.dateComponents([.day, .month, .year, .weekday], from: now)
            anchorComponents.hour = 0
            anchorComponents.minute = 0
            anchorComponents.second = 0
            guard let anchorDate = calendar.date(from: anchorComponents) else { return }
            
            let query = HKStatisticsCollectionQuery(quantityType: stepType,
                                                    quantitySamplePredicate: predicate,
                                                    options: .cumulativeSum,
                                                    anchorDate: anchorDate,
                                                    intervalComponents: interval)
            
            query.initialResultsHandler = { _, results, error in
                guard let results = results else {
                    print("Failed to fetch steps: \(String(describing: error))")
                    return
                }
                
                var stepsData: [StepData] = []
                results.enumerateStatistics(from: startDate, to: now) { statistics, _ in
                    if let sum = statistics.sumQuantity() {
                        let steps = Int((sum.doubleValue(for: HKUnit.count())))
                        stepsData.append(StepData(date: statistics.startDate, steps: steps))
                    }
                }
                
                DispatchQueue.main.async {
                    completion(stepsData)
                }
            }
            
            healthStore.execute(query)
        }
    

    func fetchQuantityInInterval(start: Date, end: Date, quantity: HKQuantityTypeIdentifier, completion: @escaping (Double) -> ()) {
        // Ensure HealthKit is available
        guard HKHealthStore.isHealthDataAvailable() else {
            completion(0)
            return
        }
        
        // Get the quantity type for the identifier
        guard let quantityType = HKQuantityType.quantityType(forIdentifier: quantity) else {
            completion(0)
            return
        }
        
        // Create the predicate for the specified date range
        let predicate = HKQuery.predicateForSamples(withStart: start, end: end)
        
        let quantitySample = HKSamplePredicate.quantitySample(type: quantityType, predicate: predicate)
        
        // Create the query descriptor
        let quantitySum = HKStatisticsQueryDescriptor(predicate: quantitySample, options: .cumulativeSum)
        
        // Execute the query
        Task {
            do {
                let quantityCount = try await quantitySum.result(for: healthStore)?
                    .sumQuantity()
                
                var data: Double = 0
                
                if quantityCount != nil {
                    if quantity == .stepCount {
                        data = (quantityCount?.doubleValue(for: HKUnit.count()))!
                    } else if quantity == .distanceWalkingRunning {
                        data = (quantityCount?.doubleValue(for: HKUnit.mile()))!
                    }
                }
                
                print(data)
                
                DispatchQueue.main.async {
                    completion(data)
                }
            } catch {
                DispatchQueue.main.async {
                    completion(0)
                }
            }
        }
    }

}

