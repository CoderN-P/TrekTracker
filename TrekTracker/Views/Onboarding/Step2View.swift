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
                    
                    TextField(text: $goal) {
                        Text("Enter your goal (10,000)").foregroundStyle(colorScheme == .dark ?
                                                                         Color("green_600") :
                                                                            Color("green_400")
                        )
                    }
                    .padding()
                    .background(colorScheme == .dark ?
                                Color("neutral_900") :
                                    Color("gray_100")
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    
                    Button(action: step3) {
                        Text("Continue")
                            .foregroundStyle(.white)
                    }
                    .disabled(!isValid)
                    .padding()
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                    .background(colorScheme == .dark ?
                                Color("green_900") :
                                    Color("green_500")
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    
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
