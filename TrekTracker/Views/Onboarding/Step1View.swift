//
//  Step1View.swift
//  TrekTracker
//
//  Created by Neel P on 6/24/24.
//

import SwiftUI
import SwiftData

struct Step1View: View {
    @State private var name: String = ""
    @State private var isValid = false
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
                        
                        Text("Welcome")
                            .bold()
                            .font(.system(size: 50))
                    }
                    
                    Text("What should we call you?")
                    
                    Spacer()
                    
                    TextField(text: $name) {
                        Text("Enter your name").foregroundStyle(colorScheme == .dark ?
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
                    
                    Button(action: step2) {
                        Text("Continue")
                            .foregroundStyle(.white)
                    }
                    .padding()
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                    .background(colorScheme == .dark ?
                                Color("green_900") :
                                    Color("green_500")
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 10))
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
        .onChange(of: name) {
            isValid = !name.isEmpty
        }
    }
    
    func step2(){
        if isValid {
            user.onboardingStep += 1
            user.name = name
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: User.self, configurations: config)
    let user = User(name: "neel")

    return Step1View(user: user).modelContainer(container)
}
