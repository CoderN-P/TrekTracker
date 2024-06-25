//
//  FooterView.swift
//  TrekTracker
//
//  Created by Neel P on 6/24/24.
//

import SwiftUI

struct FooterView: View {
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        HStack {
            Spacer()
            VStack {
                Image(systemName: "chart.bar.fill")
                Text("Steps")
                    .font(.system(size: 12))
                    .bold()
                Spacer()
            }
            Spacer()
            VStack {
                Image(systemName: "gear")
                Text("Settings")
                    .font(.system(size: 12))
                    .bold()
                Spacer()
            }
            Spacer()
            
            

        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: 100)
        .background(
            colorScheme == .dark ?
                Color("neutral_800")
            : Color("gray_200")
        )
    }
}

#Preview {
    FooterView()
}
