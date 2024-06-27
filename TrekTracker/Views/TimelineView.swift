//
//  TimelineView.swift
//  TrekTracker
//
//  Created by Neel P on 6/24/24.
//

import SwiftUI
import SwiftData

struct TimelineView: View {
    @Bindable var user: User
    @ObservedObject var healthKitManager: HealthKitManager
    
    var body: some View {
        let orderedSteps = user.steps
        

        GeometryReader { geometry in
            ScrollView(.horizontal){
                Spacer()
                VStack() {
                    Rectangle()
                        .frame(maxWidth: .infinity, maxHeight: 3)
                        .offset(y: 130)
                        .foregroundStyle(Color("green_500"))
                        .zIndex(/*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/)
                    HStack(alignment: .bottom, spacing: 2) {
                        ForEach(orderedSteps){step in
                            BarStatsView(
                                totalWidth: geometry.size.width-14,
                                step: step,
                                threshold: user.goal,
                                prefers: user.preferredUnit)
                        }
                    }
                }
            }
            .frame(height: 500)
            .defaultScrollAnchor(.trailing)
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: User.self, configurations: config)
    
    let user = User(name: "neel", steps: generateFakeStepData(days: 50))
    container.mainContext.insert(user)

    return TimelineView(user: user, healthKitManager: HealthKitManager()).modelContainer(container)
}
