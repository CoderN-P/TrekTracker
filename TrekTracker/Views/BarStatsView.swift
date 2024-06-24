//
//  BarStatsView.swift
//  TrekTracker
//
//  Created by Neel P on 6/24/24.
//

import SwiftUI


struct BarStatsView: View {
    @Environment(\.colorScheme) var colorScheme
    
    var totalWidth: CGFloat
    var steps: Int
    var threshold: Int
    var date: Date
    
    var body: some View {
        VStack {
            Text(steps.formatted())
                .foregroundStyle(getBarColor(steps: steps, threshold: threshold))
                .bold()
            VStack{
                Spacer()
                Text("1 mi")
                    .bold()
                    .font(.system(size: 15))
                    .foregroundStyle(
                        colorScheme == .dark ? .black : .white)
                
            }
            .padding([.bottom])
            .frame(width: totalWidth/7,
                   height: getBarHeight(steps: steps,  threshold: threshold)
            )
            
            .background(getBarColor(steps: steps, threshold: threshold))
            .clipShape(
                .rect(
                    topLeadingRadius: 15,
                    bottomLeadingRadius: 2,
                    bottomTrailingRadius: 2,
                    topTrailingRadius: 15
                )
            )
            Text(getBarString(date))
                .bold()
                .foregroundStyle(.white)
        }
        
    }
}

#Preview {
    
    
    BarStatsView(
        totalWidth: CGFloat(350),
        steps: 10000,
        threshold: 10000,
        date: getPastDate()
    )
    
}
