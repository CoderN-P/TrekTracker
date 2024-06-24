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
            VStack {
                Image(systemName: "bars")
                Text("Steps")
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
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
