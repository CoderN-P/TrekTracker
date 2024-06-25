//
//  User.swift
//  TrekTracker
//
//  Created by Neel P on 6/25/24.
//

import Foundation
import SwiftData


@Model
class User {
    var name: String
    var goal: Int
    var workouts: [Workout]
    var steps: [StepData]
    var onboardingStep: Int
    var authenticatedHealthKit: Bool
    
    init(name: String, goal: Int = 10000, workouts: [Workout] = [], steps: [StepData] = [], onboardingStep: Int = 1, authenticatedHealthKit: Bool = false){
        self.name = name
        self.goal = goal
        self.workouts = workouts
        self.steps = steps
        self.onboardingStep = onboardingStep
        self.authenticatedHealthKit = authenticatedHealthKit
    }
}
