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
            Text("hello")
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(
            colorScheme == .dark ?
                Color("gray_800")
            : Color("gray_200")
        )
    }
}

#Preview {
    FooterView()
}
