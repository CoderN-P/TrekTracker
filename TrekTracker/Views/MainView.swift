//
//  MainView.swift
//  TrekTracker
//
//  Created by Neel P on 6/24/24.
//

import SwiftUI
import SwiftData

struct MainView: View {
    @State private var activePage = "steps"
    @StateObject var healthKitManager = HealthKitManager()
    @Environment(\.modelContext) var modelContext
    @Query var users: [User]
    
    
    var body: some View {
        if users.count == 0 {
            IntroView()
        } else if users[0].onboardingStep == 1 {
            Step1View(user: users[0])
        } else if users[0].onboardingStep == 2 {
            Step2View(user: users[0])
        } else if users[0].onboardingStep == 3 {
            RequestHealthKitView(user: users[0], healthKitManager: healthKitManager)
        } else {
            VStack {
                HeaderView(text: activePage.capitalized)
                if (activePage == "steps"){
                    HomeView(healthKitManager: healthKitManager, user: users[0])
                } else if (activePage == "workouts"){
                    ExercisesView()
                } else {
                    SettingsView(user: users[0])
                }
                FooterView(activePage: $activePage)
            }
            .ignoresSafeArea()
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: User.self, configurations: config)
    
    let fakeData = generateFakeStepData(days: 50)
    
    print(fakeData[0].date)
    let user = User(
        name: "John Doe",
        goal: 10000,
        workouts: [], // Assuming Workout is another class you have
        steps: fakeData,
        onboardingStep: 4,
        authenticatedHealthKit: true,
        fetchedPastData: true,
        preferredUnit: "mile"
    )
    
    container.mainContext.insert(user)

    return MainView().modelContainer(container)
}
