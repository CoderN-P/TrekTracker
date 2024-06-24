//
//  ContentView.swift
//  TrekTracker
//
//  Created by Neel P on 6/24/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(alignment: .leading) {
            
            Text(getTimeString())
                .fontWeight(.semibold)
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            
            Text(getDate())
            
            Spacer()
            VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/) {
                Text("1000")
                    .font(.system(size: 80))
                    .bold()
                Text("2 mi")
                    .font(.system(size: 40))
                    .bold()
            }
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)

            Spacer()
            
            TimelineView()
            
            Spacer()
            
            FooterView()
        }
        .frame(maxWidth: .infinity)
        .ignoresSafeArea()
    
    }
}

#Preview {
    ContentView()
}
