//
//  SettingsView.swift
//  TrekTracker
//
//  Created by Neel P on 6/24/24.
//

import SwiftUI
import SwiftData
import StoreKit

struct SettingsView: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.requestReview) var requestReview
    @Bindable var user: User
    
    var body: some View {
        let accentSelected = colorScheme == .dark ? Color("green_900") : Color("green_400")
        let accentText = colorScheme == .dark ? Color("green_400") : Color("green_800")
        let bgColor = colorScheme == .dark ? Color("neutral_800") : Color("neutral_200")
    
        
        VStack {
            VStack(alignment: .leading) {
                Text("Preferred Unit")
                    .bold()
                    .font(.system(size: 24))
                
                HStack(spacing: 0) {
                    Button(action: {
                        user.preferredUnit = "km"
                    }){
                        Text("Kilometer")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .foregroundStyle(accentText)
                            .bold()
                            .background(user.preferredUnit == "km" ? accentSelected: bgColor)
                            .clipShape(.rect(
                                topLeadingRadius: 15,
                                bottomLeadingRadius: 15
                            ))
                    }
                    .sensoryFeedback(.selection, trigger: user.preferredUnit)
                    Button(action: {
                        user.preferredUnit = "mile"
                    }) {
                        Text("Mile")
                            .frame(maxWidth: .infinity)
                            .bold()
                            .foregroundStyle(accentText)
                            .padding()
                            .background(user.preferredUnit == "mile" ? accentSelected: bgColor)
                            .clipShape(.rect(
                                bottomTrailingRadius: 15, topTrailingRadius: 15
                            ))
                    }
                    .sensoryFeedback(.selection, trigger: user.preferredUnit)
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(colorScheme == .dark ? Color("neutral_900") : Color("gray_50"))
            .clipShape(RoundedRectangle(cornerRadius: 15))
            
            VStack(alignment: .leading) {
                Text("Goal")
                    .bold()
                    .font(.system(size: 24))
                
                HStack(spacing: 0) {
                    Button(action: {
                        user.goal += 100
                    }){
                        Image(systemName: "plus")
                            .frame(maxWidth: 30, maxHeight: 20)
                            .padding()
                            .foregroundStyle(accentText)
                            .bold()
                            .background(bgColor)
                            .clipShape(.rect(
                                topLeadingRadius: 15,
                                bottomLeadingRadius: 15
                            ))
                    }
                    .sensoryFeedback(.increase, trigger: user.goal)
                    
                    Button(action: {
                        user.goal -= 100
                    }) {
                        Image(systemName: "minus")
                            .frame(maxWidth: 30, maxHeight: 20)
                            .bold()
                            .foregroundStyle(accentText)
                            .padding()
                            .background(bgColor)
            
                    }
                    .sensoryFeedback(.decrease, trigger: user.goal)
                    .disabled(user.goal == 1000)
                    
                    Text(user.goal.formatted())
                        .frame(maxWidth: .infinity)
                        .padding()
                        .font(.system(size: 20))
                        .foregroundStyle(accentText)
                        .bold()
                        .background(bgColor)
                        .clipShape(.rect(
                            bottomTrailingRadius: 15,
                            topTrailingRadius: 15
                        ))

                        
                }
                
                
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(colorScheme == .dark ? Color("neutral_900") : Color("gray_50"))
            .clipShape(RoundedRectangle(cornerRadius: 15))
            
            VStack(alignment: .leading) {
                Text("Leave a review!")
                    .bold()
                    .font(.system(size: 24))
                
                
                Button(action: {
                    requestReview()
                }) {
                   Text("Thank you!")
                       .foregroundColor(.white)
                       .padding()
                       .frame(maxWidth: .infinity) // Make the text take full width
                       .background(accentSelected)
                       .cornerRadius(10)
               }
               .frame(maxWidth: .infinity) // Make the button take full width
                
                
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(colorScheme == .dark ? Color("neutral_900") : Color("gray_50"))
            .clipShape(RoundedRectangle(cornerRadius: 15))
        }
        .padding()
        
        
        
        Spacer()
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

    return SettingsView(user: user)
}
