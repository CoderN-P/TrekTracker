/*import Foundation
import HealthKit
import WidgetKit

class HealthKitManager: ObservableObject {
    static let shared = HealthKitManager()

    var healthStore = HKHealthStore()
    var authorized = false

    var stepCountToday: Int = 0
    var thisWeekSteps: [Int: Int] = [1: 0, 2: 0, 3: 0,
                                   4: 0, 5: 0, 6: 0, 7: 0]
    
    init() {
      requestAuthorization()
    }


    func requestAuthorization() {
   // this is the type of data we will be reading from Health (e.g stepCount)
      let toReads = Set([
        HKObjectType.quantityType(forIdentifier: .stepCount)!,

  // this is to make sure User's Heath Data is Avaialble
     /* guard HKHealthStore.isHealthDataAvailable() else {
        return
      }*/

  // asking User's permission for their Health Data
  // note: toShare is set to nil since I'm not updating any data
      healthStore.requestAuthorization(toShare: nil, read: toReads) {
        success, error in
        if success {
            self.authorized = true
            self.readStepCountToday()
        } else {
            print("\(String(describing: error))")
        }
      }
    }
        
    func readStepCountToday() {
        guard self.authorized else {
            self.requestAuthorization()
            return
        }
        
        guard let stepCountType = HKQuantityType.quantityType(forIdentifier: .stepCount) else {
          return
      }

      let now = Date()
      let startDate = Calendar.current.startOfDay(for: now)
      let predicate = HKQuery.predicateForSamples(
        withStart: startDate,
        end: now,
        options: .strictStartDate
      )

      let query = HKStatisticsQuery(
        quantityType: stepCountType,
        quantitySamplePredicate: predicate,
        options: .cumulativeSum
      ) {
        _, result, error in
        guard let result = result, let sum = result.sumQuantity() else {
          print("failed to read step count: \(error?.localizedDescription ?? "UNKNOWN ERROR")")
          return
        }

        let steps = Int(sum.doubleValue(for: HKUnit.count()))
        self.stepCountToday = steps
      }
      healthStore.execute(query)
    }
}
*/
