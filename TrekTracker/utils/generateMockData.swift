//
//  generateMockData.swift
//  TrekTracker
//
//  Created by Neel P on 6/26/24.
//

import Foundation


func generateFakeStepData(days: Int) -> [StepData] {
    var stepsData: [StepData] = []
    let calendar = Calendar.current
    
    for i in 0..<days {
        guard let date = calendar.date(byAdding: .day, value: -i, to: Date()) else { continue }
        
        let steps = Int.random(in: 0...15000)
        let distance = Double(steps) * 0.0008  // Approx. 0.8 meters per step
        let calories = Int(Double(steps) * 0.04)    // Approx. 0.04 calories per step
        
        let stepData = StepData(date: i == 0 ? getPastDate() : date, steps: i == 0 ? 10000 : steps, distance: distance, calories: calories)
        stepsData.append(stepData)
    }
    return stepsData.reversed()
}
