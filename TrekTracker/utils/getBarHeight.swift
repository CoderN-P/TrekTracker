//
//  getBarHeight.swift
//  TrekTracker
//
//  Created by Neel P on 6/24/24.
//

import Foundation


func getBarHeight(steps: Int, threshold: Int) -> CGFloat {
    return min(CGFloat(steps/threshold)*200.0, 400.0)
}
