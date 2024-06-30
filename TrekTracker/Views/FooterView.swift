//
//  FooterView.swift
//  TrekTracker
//
//  Created by Neel P on 6/24/24.
//

import SwiftUI

struct FooterView: View {
    @Environment(\.colorScheme) var colorScheme
    @Binding var activePage: String
    @Binding var workout: Workout?
    
    var body: some View {
        HStack {
            Spacer()
            Button(action: setActiveSteps) {
                VStack {
                    Image(systemName: "chart.bar.fill")
                    Text("Steps")
                        .font(.system(size: 12))
                        .bold()
                    Spacer()
                }
                .foregroundStyle(activePage == "steps" ? Color("green_500") : Color(colorScheme == .dark ? .white : .black))
            }
            Spacer()
            Button(action: setActiveWorkouts){
                VStack {
                    Image(systemName: "figure.run")
                    Text("Workouts")
                        .font(.system(size: 12))
                        .bold()
                    Spacer()
                }
                .foregroundStyle(activePage == "workouts" ? Color("green_500") : Color(colorScheme == .dark ? .white : .black))
            }
            Spacer()
            Button(action: setActiveSettings){
                VStack {
                    Image(systemName: "gear")
                    Text("Settings")
                        .font(.system(size: 12))
                        .bold()
                    Spacer()
                }
                .foregroundStyle(activePage == "settings" ? Color("green_500") : Color(colorScheme == .dark ? .white : .black))
            }
            Spacer()

        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: 70)
        .background(
            colorScheme == .dark ?
                Color("neutral_800")
            : Color("gray_200")
        )
        .overlay(
                Rectangle()
                    .frame(maxWidth: .infinity, maxHeight: 1)
                    .foregroundColor(colorScheme == .dark ? Color("gray_600") : Color("gray_400")),
                alignment: .top
            )
    }
    
    func setActiveSteps() {
        activePage = "steps"
        workout = nil
    }
    
    func setActiveWorkouts() {
        activePage = "workouts"
        workout = nil
    }
    
    func setActiveSettings() {
        activePage = "settings"
        workout = nil
    }
}

#Preview {
    struct FooterPreview : View {
          @State private var activePage = "steps"
         @State private var workout: Workout? = nil

          var body: some View {
              FooterView(activePage: $activePage, workout: $workout)
          }
       }

       return FooterPreview()
}
