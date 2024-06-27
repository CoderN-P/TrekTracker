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
    var step: StepData
    var threshold: Int
    var prefers: String
    
    
    var body: some View {
        let dateSplit = getBarString(step.date).split(whereSeparator: \.isNewline)
        let date1 = dateSplit[0]
        let date2 = dateSplit.count == 2 ? dateSplit[1] : "\n"
        
        VStack {
            Text(step.steps.formatted())
                .foregroundStyle(getBarColor(steps: step.steps, threshold: threshold))
                .bold()
                .font(.system(size: 12))
            VStack{
                Spacer()
                Text("\(round(step.distance*10*(prefers == "km" ? 1.609 : 1))/10) " + (prefers == "km" ? "km" : "mi"))
                    .bold()
                    .font(.system(size: 15))
                    .foregroundStyle(
                        colorScheme == .dark ? .black : .white)
                
            }
            .padding([.bottom])
            .frame(width: totalWidth/7,
                   height: getBarHeight(steps: step.steps,  threshold: threshold)
            )
            
            .background(getBarColor(steps: step.steps, threshold: threshold))
            .clipShape(
                .rect(
                    topLeadingRadius: 10,
                    bottomLeadingRadius: 2,
                    bottomTrailingRadius: 2,
                    topTrailingRadius: 10
                )
            )
            VStack {
                Text(date1)
                    .bold()
                
                Text(date2)
                    .font(.system(size: 14))
            }
            .frame(height: 30)
        }
        
    }
}

#Preview {
    
    
    BarStatsView(
        totalWidth: CGFloat(350),
        step: generateFakeStepData(days: 1)[0],
        threshold: 10000,
        prefers: "km"
    )
    
}
