//
//  SalesPageView.swift
//  MeditationAppSwiftUI
//
//  Created by Bartek Daniel on 4/23/24.
//

import SwiftUI

struct SalesPageView: View {
    
    var onExit: () -> Void
    
    var body: some View {
        VStack {
            Text("This is a sales page")
            
            Button(action: {
                onExit()
            }) {
                Text("Exit")
            }
            .padding()
            
        }
    }
}

#Preview {
    SalesPageView {
        print("On Next clicked")
    }
}
