//
//  BarStatsView.swift
//  TrekTracker
//
//  Created by Neel P on 6/24/24.
//

import SwiftUI

struct BarStatsView: View {
    @Environment(\.colorScheme) var colorScheme
    var steps: Int
    var threshold: Int
    
    var body: some View {
        VStack{
            Spacer()
            Text("1 mi")
                .bold()
                .font(.system(size: 15))
                .foregroundStyle(
                    colorScheme == .dark ? .black : .white)
                
        }
        .padding([.bottom])
        .frame(width: 50, height: getBarHeight(steps: steps, threshold: threshold))
    
        .background(getBarColor(steps: steps, threshold: threshold))
        .clipShape(
            .rect(
                topLeadingRadius: 15,
                bottomLeadingRadius: 2,
                bottomTrailingRadius: 2,
            topTrailingRadius: 15
            )
        )
    }
}

#Preview {
    BarStatsView(
        steps: 10000,
    threshold: 10000)
}
