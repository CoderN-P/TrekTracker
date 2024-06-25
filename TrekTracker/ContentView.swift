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
            VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/) {
                Spacer()
                HStack(alignment: .center) {
                    Image("Logo")
                        .resizable()
                        .frame(width: 70, height:70)
                    Text("TrekTracker")
                        .font(.title)
                        .bold()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: 100)
            .background(Color("blue_50"))
            
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
            
            FooterView()
        }
        .frame(maxWidth: .infinity)
        .ignoresSafeArea()
    
    }
}

#Preview {
    ContentView()
}
