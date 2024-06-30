//
//  WorkoutCardView.swift
//  TrekTracker
//
//  Created by Neel P on 6/28/24.
//

import SwiftUI
import SwiftData

struct WorkoutCardView: View {
    var workout: Workout
    var workoutTimer: WorkoutUpdater?
    @Bindable var user: User
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                HStack {
                    Text(workout.active == 1 ? "Active" : workout.active == 2 ? "Paused" : "Ended")
                        .font(.headline)
                    Text(getDate(date: workout.startDate))
                        .font(.subheadline)
                }
                
                Text(formatSeconds(workout.duration))
                    .foregroundStyle(Color("green_400"))
                    .font(.title)
            }
            Spacer()
            VStack(alignment: .trailing) {
                HStack {
                    HStack {
                        Text("\(workout.steps)")
                        Image(systemName: "figure.walk")
                            .font(.caption)
                    }
                    .font(.headline)
                    .foregroundStyle(Color("orange_500"))
                    Text("\(round(workout.distance*10)/10) " + user.preferredUnit == "mile" ? "mi" : "km")
                        .font(.headline)
                        .foregroundStyle(Color("orange_500"))
                }
                Spacer()
                Button(action: {
                    workout.active = workout.active == 1 ? 2 : 1
                    if workoutTimer == nil {
                        return
                    }
                    if workout.active == 1 {
                        workoutTimer!.resume()
                    } else {
                        workoutTimer!.pause()
                    }
                    
                }) {
                    Image(systemName: workout.active == 1 ? "pause.fill" : "play.fill")
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: 90)
        .background(Color("neutral_900"))
        .clipShape(RoundedRectangle(cornerRadius: 15))
        
        
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: User.self, configurations: config)
    let user = User(name: "neel")
    
    let healthKitManager = HealthKitManager()
    
    let workout = Workout(healthKitManager: healthKitManager)
    
    let locationManager = LocationManager()

    return WorkoutCardView(workout: workout, workoutTimer: WorkoutUpdater(workout: workout, healthKitManager: healthKitManager, locationManager: locationManager), user: user).modelContainer(container)
}
