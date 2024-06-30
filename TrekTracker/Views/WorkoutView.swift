//
//  WorkoutView.swift
//  TrekTracker
//
//  Created by Neel P on 6/24/24.
//

import SwiftUI
import MapKit
import SwiftData

struct WorkoutView: View {
    var workout: Workout
    @ObservedObject var locationManager: LocationManager
    
    var body: some View {
        VStack {
            Map() {
                ForEach(workout.location, id: \.self){location in
                    Marker("a", coordinate: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)).tint(.orange)
                }
            }
            .frame(height: 300) // Adjust the map height as needed
            VStack {
                HStack {
                    Text("Workout")
                        .font(.title)
                        .bold()
                    Spacer()
                    Text(getDate(date: workout.startDate))
                }
            }
            .padding()
        }
        .onAppear {
            locationManager.checkLocationAuthorization()
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: User.self, configurations: config)
    let user = User(name: "neel")

    return WorkoutView(workout: Workout(healthKitManager: HealthKitManager()), locationManager: LocationManager()).modelContainer(container)
}


