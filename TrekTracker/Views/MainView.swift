//
//  MainView.swift
//  TrekTracker
//
//  Created by Neel P on 6/24/24.
//

import SwiftUI

struct MainView: View {
    @State private var onboardingStep: Int = 1
    @State private var activePage = "steps"
    
    var body: some View {
        if onboardingStep == 1 {
            Step1View(onboardingStep: $onboardingStep
            )
        } else if onboardingStep == 2 {
            Step2View(onboardingStep: $onboardingStep
            )
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
}

#Preview {
    MainView()
}
