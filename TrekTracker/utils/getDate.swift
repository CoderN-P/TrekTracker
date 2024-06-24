//
//  getDate.swift
//  TrekTracker
//
//  Created by Neel P on 6/24/24.
//

import Foundation


func getDate() -> String {
    let currentDate = Date()
    let dateFormatter = DateFormatter()
    
    
    return dateFormatter.string(from: currentDate)
}
