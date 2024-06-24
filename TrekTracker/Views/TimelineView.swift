//
//  TimelineView.swift
//  TrekTracker
//
//  Created by Neel P on 6/24/24.
//

import SwiftUI

struct TimelineView: View {
    var body: some View {
        GeometryReader { geometry in
            
            ScrollView(.horizontal){
                Spacer()
                VStack {
                    Rectangle()
                        .frame(width: .infinity, height: 3)
                        .offset(y: 200)
                        .foregroundStyle(Color("green_500"))
                        .zIndex(/*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/)
                    HStack(alignment: .bottom) {
                        ForEach(0..<10){i in
                            BarStatsView(
                                totalWidth:geometry.size.width-50, steps: i*1000,
                                threshold: 10000,
                                date: Date())
                        }
                    }
                }
            }
            .frame(height: 500)
            
        }
    }
}

#Preview {
    TimelineView()
}
