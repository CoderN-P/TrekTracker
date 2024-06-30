//
//  Location.swift
//  TrekTracker
//
//  Created by Neel P on 6/29/24.
//

import Foundation
import SwiftData

@Model
class Location {
    
    var latitude: Double
    var longitude: Double
    
    init(latitude: Double = 0, longitude: Double = 2){
        self.latitude = latitude
        self.longitude = longitude
    }
}
