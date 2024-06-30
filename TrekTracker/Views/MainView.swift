//
//  MainView.swift
//  TrekTracker
//
//  Created by Neel P on 6/24/24.
//

import SwiftUI
import SwiftData

struct MainView: View {
    @State private var activePage = "steps"
    @State private var currentWorkout: Workout? = nil
    @State private var activeWorkoutTimers: [WorkoutUpdater] = []
    @StateObject var healthKitManager = HealthKitManager()
    @StateObject var locationManager = LocationManager()
    @Environment(\.modelContext) var modelContext
    @Query var users: [User]
    
    var body: some View {
        if users.count == 0 {
            IntroView()
        } else if users[0].onboardingStep == 1 {
            Step1View(user: users[0])
        } else if users[0].onboardingStep == 2 {
            Step2View(user: users[0])
        } else if users[0].onboardingStep == 3 {
            if users[0].authenticatedHealthKit == true {
                LoadingView()
            } else {
                RequestHealthKitView(user: users[0], healthKitManager: healthKitManager)
            }
        } else {
            VStack {
                HeaderView(text: activePage.capitalized, createNewWorkout: createNewWorkout)
                if (currentWorkout != nil) {
                    WorkoutView(workout: currentWorkout!, locationManager: locationManager)
                } else if (activePage == "steps"){
                    HomeView(healthKitManager: healthKitManager, user: users[0])
                } else if (activePage == "workouts"){
                    ExercisesView(user: users[0], currentWorkout: $currentWorkout, workoutTimers: activeWorkoutTimers)
                } else {
                    SettingsView(user: users[0])
                }
                FooterView(activePage: $activePage, workout: $currentWorkout)
            }
            .onAppear() {
                if users[0].steps.count > 0 && Calendar.current.isDate(users[0].steps[users[0].steps.count - 1].date, equalTo: Date(), toGranularity: .day){
                    healthKitManager.fetchQuantityToday(quantity: .stepCount) {data in
                        users[0].steps[users[0].steps.count - 1].steps = Int(data)
                   }
                   healthKitManager.fetchQuantityToday(quantity: .distanceWalkingRunning) {data in
                        users[0].steps[users[0].steps.count - 1].distance = data
                    }
                    
                    healthKitManager.observeQuantity(quantity: .stepCount) {
                        data in
                        print(data)
                        users[0].steps[users[0].steps.count - 1].steps = Int(data)
                    }
                    
                    healthKitManager.observeQuantity(quantity: .distanceWalkingRunning) {
                        data in
                        users[0].steps[users[0].steps.count - 1].distance = data
                    }
                } else {
                    
                    let curStepData = StepData(date: Date())
                    let dispatchGroup = DispatchGroup()
                    
                    dispatchGroup.enter()
                    healthKitManager.fetchQuantityToday(quantity: .stepCount) {data in
                        curStepData.steps = Int(data)
                        dispatchGroup.leave()
                    }
                    dispatchGroup.enter()
                    healthKitManager.fetchQuantityToday(quantity: .distanceWalkingRunning) {data in
                        curStepData.distance = data
                        dispatchGroup.leave()
                    }
                    
                    dispatchGroup.notify(queue: .main) {
                        print("adding today \(curStepData.date)")
                        users[0].steps.append(curStepData)
                        
                        healthKitManager.observeQuantity(quantity: .stepCount) {
                            data in
                            users[0].steps[users[0].steps.count - 1].steps = Int(data)
                        }
                        
                        healthKitManager.observeQuantity(quantity: .distanceWalkingRunning) {
                            data in
                            users[0].steps[users[0].steps.count - 1].distance = data
                        }
                    }
               }

               
            }
            .ignoresSafeArea()
        }
    }
    
    func createNewWorkout(){
        let newWorkout = Workout(healthKitManager: healthKitManager)
        users[0].workouts.append(newWorkout)
        activeWorkoutTimers.append(WorkoutUpdater(
        workout: newWorkout, healthKitManager: healthKitManager, locationManager: locationManager))
        currentWorkout = newWorkout
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: User.self, configurations: config)
    
    let fakeData = generateFakeStepData(days: 300)
    
    print(fakeData[0].date)
    let user = User(
        name: "John Doe",
        goal: 10000,
        workouts: [], // Assuming Workout is another class you have
        steps: fakeData,
        onboardingStep: 4,
        authenticatedHealthKit: true,
        fetchedPastData: true,
        preferredUnit: "mile"
    )
    
    container.mainContext.insert(user)

    return MainView().modelContainer(container)
}
