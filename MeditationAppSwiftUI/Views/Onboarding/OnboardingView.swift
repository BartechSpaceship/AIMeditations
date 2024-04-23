//
//  OnboardingView.swift
//  MeditationAppSwiftUI
//
//  Created by Bartek Daniel on 4/22/24.
//

import SwiftUI

struct OnboardingView: View {
    //    @AppStorage(UserDefaultsConstants.isOnboardingComplete) var isOnboardingComplete: Bool = false
    @State private var onboardingStep = 1
    @Binding var isOnboardingComplete: Bool
    
    var body: some View {
        VStack {
            if onboardingStep == 1 {
                OnboardingStepOneView(onNext: {
                    withAnimation {
                        onboardingStep = 2
                    }
                })
                .transition(.opacity)
            } else if onboardingStep == 2 {
                OnboardingStepTwoView(onNext: {
                    withAnimation {
                        onboardingStep = 3
                    }
                })
                .transition(.opacity)
            } else if onboardingStep == 3 {
                SalesPageView {
                    isOnboardingComplete = true
                }
                .transition(.opacity)
            }
        }
        .animation(.easeInOut(duration: 0.5), value: onboardingStep)
        
    }
}

#Preview {
    OnboardingView(isOnboardingComplete: .constant(false))
}
