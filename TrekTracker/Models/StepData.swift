//
//  StepData.swift
//  TrekTracker
//
//  Created by Neel P on 6/25/24.
//

import Foundation
import SwiftData


@Model
class StepData: Identifiable {
    var id: UUID = UUID()
    var date: Date
    var steps: Int = 0
    var distance: Double
    var calories: Int
    
    init(date: Date = Date(), steps: Int = 0, distance: Double = 0, calories: Int = 0){
        self.date = date
        self.steps = steps
        self.distance = distance
        self.calories = calories
    }
}
