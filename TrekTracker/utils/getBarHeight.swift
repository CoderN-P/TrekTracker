//
//  getBarHeight.swift
//  TrekTracker
//
//  Created by Neel P on 6/24/24.
//

import Foundation


func getBarHeight(steps: Int, threshold: Int) -> CGFloat {
    return CGFloat(min(Double((steps*200)/threshold), 300.0))
}
