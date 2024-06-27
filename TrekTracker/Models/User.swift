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
    var name: String = ""
    var goal: Int = 10000
    var workouts: [Workout] = []
    var steps: [StepData] = []
    var onboardingStep: Int = 1
    var authenticatedHealthKit: Bool = false
    var fetchedPastData: Bool = false
    var preferredUnit: String = "mile"
    
    init(name: String = "", goal: Int = 10000, workouts: [Workout] = [], steps: [StepData] = [], onboardingStep: Int = 1, authenticatedHealthKit: Bool = false, fetchedPastData: Bool = false, preferredUnit: String = "mile"){
        self.name = name
        self.goal = goal
        self.workouts = workouts
        self.steps = steps
        self.onboardingStep = onboardingStep
        self.authenticatedHealthKit = authenticatedHealthKit
        self.fetchedPastData = fetchedPastData
        self.preferredUnit = preferredUnit
    }
}

