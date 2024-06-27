//
//  Workout.swift
//  TrekTracker
//
//  Created by Neel P on 6/25/24.
//

import Foundation
import SwiftData

@Model
class Workout {
    var duration: Int // Amount of seconds
    
    init(duration: Int = 0){
        self.duration = duration
    }
}
