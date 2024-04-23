//
//  MeditationAppSwiftUIApp.swift
//  MeditationAppSwiftUI
//
//  Created by Bartek Daniel on 4/21/24.
//

import SwiftUI

//the body must return some sort of "scene"
//WindowGroup: This is a scene type used for a group of windows that share the same content.
//In a typical iOS app, this usually represents the main (or only) UI of the app. In your case, it presents the ContentView.

@main
struct MeditationAppSwiftUIApp: App {
    @State private var isActive = false
    @AppStorage(UserDefaultsConstants.isOnboardingComplete) private var isOnboardingComplete = false
    
    init() {
        isOnboardingComplete = true
    }
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                if isActive {
                    if isOnboardingComplete {
                        ContentView()
                            .transition(.opacity)
                    } else {
                        OnboardingView(isOnboardingComplete: $isOnboardingComplete)
                            .transition(.opacity)
                    }
                } else {
                    LaunchView()
                }
            }
            .animation(.easeInOut(duration: 1.0), value: isActive)
            .animation(.easeInOut(duration: 0.5), value: isOnboardingComplete)
            .onAppear(perform: startLaunchSequence)
        }
    }
    
    private func startLaunchSequence() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            withAnimation {
                self.isActive = true
            }
        }
    }
}
