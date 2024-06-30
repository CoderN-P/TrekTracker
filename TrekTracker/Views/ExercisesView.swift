//
//  ExercisesView.swift
//  TrekTracker
//
//  Created by Neel P on 6/24/24.
//

import SwiftUI
import SwiftData

struct ExercisesView: View {
    @Bindable var user: User
    @Binding var currentWorkout: Workout?
    var workoutTimers: [WorkoutUpdater]
    
    var body: some View {
        List {
            Section(header: Text("Active")){
                ForEach(user.workouts, id: \.self){ workout in
                    Button(action: {
                        currentWorkout = workout
                    }){
                        if workout.active != 3 {
                            WorkoutCardView(
                                workout: workout,
                                workoutTimer: workoutTimers.first(){
                                    $0.workout == workout
                                },
                                user: user
                            )
                        }
                    }
                }
            }
            
            Section(header: Text("Ended")){
                ForEach(user.workouts, id: \.self){ workout in
                    Button(action: {
                        currentWorkout = workout
                    }){
                        if workout.active == 3 {
                            WorkoutCardView(
                                workout: workout,
                                workoutTimer: workoutTimers.first(){
                                    $0.workout == workout
                                },
                                user: user
                            )
                        }
                    }
                }
            }
        }
        Spacer()
    }
}

#Preview {
     @State var workout: Workout? = nil
    
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: User.self, configurations: config)
    
    let healthKitManager = HealthKitManager()
    let locationManager = LocationManager()
    
    let user = User(workouts: [Workout(), Workout()])
    
    let wkTimer1 = WorkoutUpdater(workout: user.workouts[0], healthKitManager: healthKitManager, locationManager: locationManager)
    
    let wkTimer2 = WorkoutUpdater(workout: user.workouts[1], healthKitManager: healthKitManager, locationManager: locationManager)
    let workoutTimers = [wkTimer1, wkTimer2]
    
    
    container.mainContext.insert(user)
         
    return ExercisesView(user: user, currentWorkout: $workout, workoutTimers: workoutTimers)
    .modelContainer(container)
    
}
