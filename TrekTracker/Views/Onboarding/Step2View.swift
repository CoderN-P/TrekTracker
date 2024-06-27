//
//  Step1View.swift
//  TrekTracker
//
//  Created by Neel P on 6/24/24.
//

import SwiftUI
import SwiftData

struct Step2View: View {
    @State var goal: String = ""
    @State var isValid: Bool = false
    @Bindable var user: User
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                VStack {
                    Spacer()
                    Text("TrekTracker")
                        .bold()
                        .font(.system(size: 50))
                        .offset(y: 75)
                    ZStack {
                        
                        Image("Logo")
                            .resizable()
                            .aspectRatio(1, contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                            .frame(maxWidth: .infinity, maxHeight: 200)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: 300)
                .background(colorScheme == .dark ? Color("green_800") :
                                Color("green_200")
                )
                
                
                
                VStack {
                    HStack {
                        Text("Hi \(user.name)")
                            .bold()
                            .font(.system(size: 50))
                    }
                    
                    Text("Create a daily step goal!")
                    
                    Spacer()
                    
                    ZStack {
                        // Background with corner radius
                        RoundedRectangle(cornerRadius: 10)
                            .fill(colorScheme == .dark ? Color("neutral_900") : Color("gray_100"))
                            .frame(maxWidth: .infinity, maxHeight: 50) // Ensure clickable area
                        
                        // TextField with padding and foreground color
                        TextField(text: $goal) {
                            Text("Enter your goal")
                            
                            .foregroundColor(colorScheme == .dark ? Color("green_600") : Color("green_400"))
                            .frame(maxWidth: .infinity, minHeight: 44) // Ensure clickable area
                            .background(Color.clear) // Ensure background doesn't affect layout
                        }
                        .padding()
                    }
                    
                    Button(action: step3) {
                       Text("Continue")
                           .foregroundColor(.white)
                           .padding()
                           .frame(maxWidth: .infinity) // Make the text take full width
                           .background(colorScheme == .dark ? Color("green_900") : Color("green_500"))
                           .cornerRadius(10)
                   }
                   .frame(maxWidth: .infinity) // Make the button take full width
                   .disabled(!isValid)
                    
                    Spacer()
                }
                .padding(30)
                .background(colorScheme == .dark ? .black :
                        .white)
                .clipShape(.rect(
                    topLeadingRadius: 50,
                    topTrailingRadius: 50
                ))
                
            }
            .background(colorScheme == .dark ? Color("green_800") :
                            Color("green_200"))
            .ignoresSafeArea()
        }
        .onChange(of: goal) {
            isValid = !goal.isEmpty
        }
    }
    
    func step3(){
        if isValid {
            user.onboardingStep += 1
            user.goal = Int(goal) ?? 10000
        }
    }
    
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: User.self, configurations: config)
    let user = User(name: "neel")

    return Step2View(user: user).modelContainer(container)
}
