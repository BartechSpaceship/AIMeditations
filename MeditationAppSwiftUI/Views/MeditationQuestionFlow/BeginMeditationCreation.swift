//
//  BeginMeditationCreation.swift
//  MeditationAppSwiftUI
//
//  Created by Bartek Daniel on 4/24/24.
//

import SwiftUI

struct BeginMeditationCreation: View {
    
    @AppStorage(UserDefaultsConstants.questionOneQuestion) private var q1Q = ""
    @AppStorage(UserDefaultsConstants.questionOneAnswer) private var q1A = ""
    @AppStorage(UserDefaultsConstants.questionTwoQuestion) private var q2Q = ""
    @AppStorage(UserDefaultsConstants.questionTwoAnswer) private var q2A = ""
    @AppStorage(UserDefaultsConstants.questionThreeQuestion) private var q3Q = ""
    @AppStorage(UserDefaultsConstants.questionThreeAnswer) private var q3A = ""
    
    @State private var selectedMeditationType: String = "Mindfulness Meditation"
    
    let meditationTypes = [
        "Mindfulness Meditation",
        "Guided Meditation",
        "Focused Meditation"
    ]
    
    var body: some View {
        VStack {
            Text("Based on your blah, we recommend x")
                .font(.title)
                .multilineTextAlignment(.center)
            
            Spacer().frame(height: 32)
            
            Text("Grae, since ou want to improve focus and concentration for work ive made a simple mindfulness meditation. ill help guide you along as you focus on centering your attention blah blag blag blag")
                .font(.subheadline)
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity)
            
            Spacer().frame(height: 102)
            
            HStack {
                
                
                
            }
            
            
        }
        
    }
    
}

#Preview {
    BeginMeditationCreation()
}
