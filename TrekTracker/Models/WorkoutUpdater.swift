//
//  WorkoutUpdater.swift
//  TrekTracker
//
//  Created by Neel P on 6/28/24.
//

import Foundation

class WorkoutUpdater {
    var durationTimer: Timer?
    var dataTimer: Timer?
    var workout: Workout
    var healthKitManager: HealthKitManager
    var locationManager: LocationManager
    
    init(workout: Workout, healthKitManager: HealthKitManager, locationManager: LocationManager) {
        self.workout = workout
        self.healthKitManager = healthKitManager
        self.locationManager = locationManager
        self.durationTimer = nil
        self.dataTimer = nil
        
        self.createDurationTimer()
        self.createDataTimer()
    }

    private func createDurationTimer(){
        durationTimer = Timer(fireAt: Date().addingTimeInterval(1), interval: 1, target: self, selector: #selector(updateDuration), userInfo: nil, repeats: true)
        RunLoop.main.add(durationTimer!, forMode: .common)
    }
    
    private func createDataTimer(){
        dataTimer = Timer(fireAt: Date(), interval: 10, target: self, selector: #selector(updateStepsLocationDistance), userInfo: nil, repeats: true)
        RunLoop.main.add(dataTimer!, forMode: .common)
    }
    
    @objc private func updateStepsLocationDistance(){
        updateDistance()
        updateSteps()
        updateLocation()
    }
    
    @objc private func updateDuration(){
        self.workout.duration += 1
    }
    
    
    @objc private func updateLocation(){
        guard let curLocation = locationManager.lastKnownLocation else {
            return
        }
        workout.location.append(Location(latitude: curLocation.coordinate.latitude, longitude: curLocation.coordinate.longitude))
    }
    
    @objc private func updateSteps(){
        healthKitManager.fetchQuantityInInterval(start: Date().addingTimeInterval(-Double(self.workout.duration)), end: Date(), quantity: .stepCount){data in
            self.workout.steps = Int(data)
        }
    }
    
    @objc private func updateDistance() {
        healthKitManager.fetchQuantityInInterval(start: Date().addingTimeInterval(-Double(self.workout.duration)), end: Date(), quantity: .distanceWalkingRunning){ data in
            print(data)
            self.workout.distance = data
        }
    }
    
    func pause(){
        self.durationTimer!.invalidate()
        self.dataTimer!.invalidate()
        self.workout.active = 2
    }
    
    func resume(){
        createDurationTimer()
        createDataTimer()
    }
    
    func end(){
        self.workout.active = 3
        self.durationTimer!.invalidate()
        self.dataTimer!.invalidate()
        self.dataTimer = nil
        self.durationTimer = nil
    }
}
