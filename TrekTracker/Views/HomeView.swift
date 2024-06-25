//
//  ContentView.swift
//  TrekTracker
//
//  Created by Neel P on 6/24/24.
//

import SwiftUI

struct HomeView: View {
    // @StateObject var healthKitManager = HealthKitManager.shared
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack(alignment: .leading) {
            
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
        }
        .frame(maxWidth: .infinity)
        .ignoresSafeArea()
    
    }
}

#Preview {
    HomeView()
}
