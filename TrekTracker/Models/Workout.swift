//
//  Workout.swift
//  TrekTracker
//
//  Created by Neel P on 6/25/24.
//

import Foundation
import SwiftData
import CoreLocation

@Model
class Workout {
    var duration: Int // Amount of seconds
    var active: Int// 1 - active, 2 paused, 3 ended
    var distance: Double // miles
    var steps: Int
    var startDate: Date
    var location: [Location]
    
    init(duration: Int = 0, active: Int = 1, distance: Double = 0, steps: Int = 0, startDate: Date = Date(), location: [Location] = [], healthKitManager: HealthKitManager? = nil){
        self.duration = duration
        self.active = active
        self.distance = distance
        self.steps = 0
        self.startDate = startDate
        self.location = location
    }

}
