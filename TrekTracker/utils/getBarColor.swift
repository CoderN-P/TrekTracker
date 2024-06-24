//
//  getBarColor.swift
//  TrekTracker
//
//  Created by Neel P on 6/24/24.
//

import Foundation
import SwiftUI

func getBarColor(steps: Int, threshold: Int) -> Color {
    if steps >= threshold {
        return Color("green_500")
    }
    
    if steps*2 < threshold {
        return Color("red_500")
    }
    
    return Color("orange_500")
}
