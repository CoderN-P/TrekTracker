//
//  IntroView.swift
//  TrekTracker
//
//  Created by Neel P on 6/25/24.
//

import SwiftUI

struct IntroView: View {
    @Environment(\.modelContext) var modelContext
    
    var body: some View {
        Button(action: addUser){
            Text("Begin")
        }
    }
    
    func addUser(){
        modelContext.insert(User())
    }
}

#Preview {
    IntroView()
}
