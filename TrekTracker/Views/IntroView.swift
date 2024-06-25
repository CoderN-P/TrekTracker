//
//  IntroView.swift
//  TrekTracker
//
//  Created by Neel P on 6/25/24.
//

import SwiftUI

struct IntroView: View {
    var addUser: () -> Void
    
    var body: some View {
        Button(action: addUser){
            Text("Begin")
        }
    }
}

#Preview {
    IntroView(addUser: addUserNull)
}

func addUserNull(){
    print("hello")
    return
}
