//
//  FindingBestMeditation.swift
//  MeditationAppSwiftUI
//
//  Created by Bartek Daniel on 4/24/24.
//

import SwiftUI

struct FindingBestMeditation: View {
    
    
    var body: some View {
        VStack {
            Spacer()
            Spacer()
            Text("One moment, I'm thinking of the best meditation for you...")
                .font(.title2)
                .multilineTextAlignment(.center)
            
            Spacer()
            
            Rectangle()
                .fill(Color.secondary)
                .aspectRatio(1, contentMode: .fit)
                .overlay(
                    Text("Image Placeholder")
                        .foregroundColor(.white)
                )
                .padding(.all, 32)
            
        
        
            Spacer()
            Spacer()
            Spacer()
            Spacer()
        }
    }
}

#Preview {
    FindingBestMeditation()
}
