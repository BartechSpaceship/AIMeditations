//
//  OnboardingView.swift
//  MeditationAppSwiftUI
//
//  Created by Bartek Daniel on 4/22/24.
//

import SwiftUI

struct OnboardingView: View {
//    A Binding in SwiftUI is a way to create a two-way connection between a property that stores data, 
//    and a view that displays and changes the data. A Binding allows for interactive updates:
//
//    When the data changes externally (like a @State variable in a parent view), the view updates to reflect the new data.
//    When the view changes the data (like a toggle switch in its body), the data updates to reflect the user interface change.
    @AppStorage(UserDefaultsConstants.isOnboardingComplete) var isOnboardingComplete: Bool = false
    @State private var onboardingStep = 1
    
    var body: some View {
        VStack {
            if onboardingStep == 1 {
                OnboardingStepOneView(onNext: {onboardingStep = 2})
                //                   OnboardingStep1View(onNext: { onboardingStep = 2 })
            } else if onboardingStep == 2 {
                OnboardingStepTwoView()
                //                   OnboardingStep2View(onNext: { onboardingStep = 3 })
            } else if onboardingStep == 3 {
                //                   OnboardingStep3View(onFinish: { isOnboardingComplete = true })
            }
        }
    }
}

#Preview {
    OnboardingView()
}
