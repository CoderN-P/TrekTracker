//
//  ContentView.swift
//  TrekTracker
//
//  Created by Neel P on 6/24/24.
//

import SwiftUI
import SwiftData


struct HomeView: View {
    // @StateObject var healthKitManager = HealthKitManager.shared
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var healthKitManager: HealthKitManager
    @Bindable var user: User
    
    var body: some View {
        var curSteps = Int(user.steps.count > 0 ? user.steps[user.steps.count - 1].steps : 0)
        var color = getBarColor(steps: curSteps, threshold: user.goal)
        var curDist = round((user.steps.count > 0 ? user.steps[user.steps.count - 1].distance : 0.0) * 10 * (user.preferredUnit == "km" ? 1.609 : 1))/10
        VStack(alignment: .leading) {
            Spacer()
            VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/) {
                
                Text(String(curSteps))
                    .font(.system(size: 80))
                    .bold()
                    .foregroundStyle(color)

                Text("\(curDist) " + (user.preferredUnit == "km" ? "km" : "mi"))
                    .font(.system(size: 40))
                    .bold()
                    .foregroundStyle(color)
            }
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
            
            Spacer()
            
            TimelineView(user: user, healthKitManager: healthKitManager)
            
            Spacer()
        }
        .onAppear() {

             if user.steps.count > 0 && Calendar.current.isDate(user.steps[user.steps.count - 1].date, equalTo: Date(), toGranularity: .day){
                 healthKitManager.fetchQuantityToday(quantity: .stepCount) {data in
                     user.steps[user.steps.count - 1].steps = Int(data)
                }
                healthKitManager.fetchQuantityToday(quantity: .distanceWalkingRunning) {data in
                     user.steps[user.steps.count - 1].distance = data
                 }
             } else {
                 let curStepData = StepData(date: Date())
                 let dispatchGroup = DispatchGroup()
                 
                 dispatchGroup.enter()
                 healthKitManager.fetchQuantityToday(quantity: .stepCount) {data in
                     curStepData.steps = Int(data)
                     dispatchGroup.leave()
                 }
                 dispatchGroup.enter()
                 healthKitManager.fetchQuantityToday(quantity: .distanceWalkingRunning) {data in
                     curStepData.distance = data
                     dispatchGroup.leave()
                 }
                 
                 dispatchGroup.notify(queue: .main) {
                     user.steps.append(curStepData)
                 }
            }

            
           
        }
        .frame(maxWidth: .infinity)
        .ignoresSafeArea()
    
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: User.self, configurations: config)
    
    let fakeData = generateFakeStepData(days: 50)
    
    let user = User(
        name: "John Doe",
        goal: 10000,
        workouts: [], // Assuming Workout is another class you have
        steps: fakeData,
        onboardingStep: 1,
        authenticatedHealthKit: true,
        fetchedPastData: true,
        preferredUnit: "mile"
    )
    
    container.mainContext.insert(user)

    return HomeView(healthKitManager: HealthKitManager(), user: user)
}
