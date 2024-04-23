//
//  LaunchView.swift
//  MeditationAppSwiftUI
//
//  Created by Bartek Daniel on 4/21/24.
//

import SwiftUI

struct LaunchView: View {
    
    
    var body: some View {
        ZStack {
            Circle()
                .frame(width: 200, height: 200)
                .foregroundColor(.gray)
            Text("Logo")
        }
        .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    LaunchView()
}
