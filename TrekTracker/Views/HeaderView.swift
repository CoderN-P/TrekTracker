//
//  HeaderView.swift
//  TrekTracker
//
//  Created by Neel P on 6/24/24.
//

import SwiftUI

struct HeaderView: View {
    @Environment(\.colorScheme) var colorScheme
    
    var text: String
    
    var body: some View {
        VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/) {
            Spacer()
            Text(text)
                .font(.title)
                .bold()
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: 100)
        .background(colorScheme == .dark ?
                    LinearGradient(gradient: Gradient(colors: [.black, Color("green_900").opacity(0.5)]), startPoint: .top, endPoint: .bottom) : LinearGradient(gradient: Gradient(colors: [.white, Color("green_200").opacity(0.5)]), startPoint: .top, endPoint: .bottom))
        .border(colorScheme == .dark ? Color("gray_800") : Color("gray_200")
        )
    }
}

#Preview {
    HeaderView(text: "hello")
}
