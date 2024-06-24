//
//  getTimeString.swift
//  TrekTracker
//
//  Created by Neel P on 6/24/24.
//

import Foundation


func getTimeString() -> String {
    let currentDate = Date()
    let calendar = Calendar.current
    let hour = calendar.component(.hour, from: currentDate)
    
    var timeString = ""
    
    if hour >= 12 {
        timeString = "Good Afternoon"
        
        if hour >= 18 {
            timeString = "Good Evening"
        }
    } else {
        timeString = "Good Morning"
    }
    
    return timeString
}
