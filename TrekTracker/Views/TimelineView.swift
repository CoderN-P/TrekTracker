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
    @State var stepsRendered = 0
    @State var steps: [StepData] = []
    @ObservedObject var healthKitManager: HealthKitManager
    @State var lastVisibleIndex: UUID?
    
    var body: some View {
        GeometryReader { geometry in
            ScrollViewReader {scrollViewProxy in
                ScrollView(.horizontal) {
                    Spacer()
                    VStack() {
                        Rectangle()
                            .frame(maxWidth: .infinity, maxHeight: 3)
                            .offset(y: 130)
                            .foregroundStyle(Color("green_500"))
                            .zIndex(/*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/)
                        HStack(alignment: .bottom, spacing: 2) {
                            ForEach(user.steps.sorted(){
                                $0.date < $1.date
                            }){stepData in
                                BarStatsView(
                                    totalWidth: geometry.size.width-14,
                                    step: stepData,
                                    threshold: user.goal,
                                    prefers: user.preferredUnit)
                                .onAppear(){
                                    if steps.firstIndex(of: stepData) == 10 {
                                        saveScrollPosition(index: stepData.id)
                                        getSteps {
                                            scrollToLastVisibleIndex(scrollViewProxy)
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
            .onAppear {
            
            }
            .frame(height: 500)
            .defaultScrollAnchor(.trailing)
        }
    }
    
    private func saveScrollPosition(index: UUID) {
        lastVisibleIndex = index
    }
    
    private func scrollToLastVisibleIndex(_ scrollViewProxy: ScrollViewProxy) {
        if let index = lastVisibleIndex {
            scrollViewProxy.scrollTo(index, anchor: .trailing)
        }
    }
    
    func getSteps(completion: @escaping () -> Void){
        DispatchQueue.global(qos: .userInitiated).async {
            let amountMore = 20
            
            var newData: [StepData]
            var newStepsRendered: Int
            
            if stepsRendered + amountMore >= user.steps.count {
                newData = Array(user.steps[0..<user.steps.count-stepsRendered])
                newStepsRendered = user.steps.count
            } else {
                newData = Array(user.steps[user.steps.count-stepsRendered-amountMore..<(user.steps.count - stepsRendered)])
                newStepsRendered = stepsRendered + 20
            }
            
            DispatchQueue.main.async {
                steps = newData + steps
                stepsRendered = newStepsRendered
                completion()
            }
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: User.self, configurations: config)
    
    let user = User(name: "neel", steps: generateFakeStepData(days: 200))
    container.mainContext.insert(user)

    return TimelineView(user: user, healthKitManager: HealthKitManager()).modelContainer(container)
}
