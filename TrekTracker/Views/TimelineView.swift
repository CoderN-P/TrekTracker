//
//  TimelineView.swift
//  TrekTracker
//
//  Created by Neel P on 6/24/24.
//

import SwiftUI

struct TimelineView: View {
    var body: some View {
        ScrollView(.horizontal){
            HStack {
                ForEach(0..<10){_ in
                    BarStatsView(steps: 10000, threshold: 10000)
                }
            }
        }
    }
}

#Preview {
    TimelineView()
}
