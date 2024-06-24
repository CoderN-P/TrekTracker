//
//  WorkoutView.swift
//  TrekTracker
//
//  Created by Neel P on 6/24/24.
//

import SwiftUI
import MapKit

struct WorkoutView: View {
    var body: some View {
        VStack {
            Map {
                
            }
            VStack {
                Text("Ran 5 Miles")
                    .font(.title)
                    .bold()
                
                
            }
        }
    }
}

#Preview {
    WorkoutView()
}
