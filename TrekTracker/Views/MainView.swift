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
    @Environment(\.modelContext) var modelContext
    @Query var users: [User]
    
    var body: some View {
        if users.count == 0 {
            IntroView(addUser: addUser)
        } else if users[0].onboardingStep == 1 {
            Step1View(user: users[0])
        } else if users[0].onboardingStep == 2 {
            Step2View(user: users[0])
        } else if users[0].onboardingStep == 3 {
            RequestHealthKitView(user: users[0])
        } else {
            VStack {
                HeaderView(text: activePage.capitalized)
                if (activePage == "steps"){
                    HomeView()
                } else if (activePage == "workouts"){
                    ExercisesView()
                } else {
                    SettingsView()
                }
                FooterView(activePage: $activePage)
            }
            .ignoresSafeArea()
        }
    }
    
    func addUser(){
        guard users.count == 0 else {
            return
        }
        
        modelContext.insert(User(name: ""))
    }
}

#Preview {
    MainView()
}
