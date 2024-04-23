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
//    @State is a property wrapper in SwiftUI that you use to declare a source of truth for simple data that your view reads or writes.
    @State private var isActive = false
    //here we are setting the default value to false, this does not set a new value 
    @AppStorage(UserDefaultsConstants.isOnboardingComplete) private var isOnboardingComplete = false

    
    var body: some Scene {
          WindowGroup {
              Group {
//                  The zIndex is set to ensure the layers stack correctly. Higher zIndex values will place views above those with lower values
                  if !isActive {
                      LaunchView()
                          .zIndex(2)
                  }
                  
                  if isActive && !isOnboardingComplete {
                      OnboardingView()
                          .zIndex(1)
                          .transition(.opacity)
                  }
                  
                  if isOnboardingComplete {
                      ContentView()
                          .zIndex(0)
                          .transition(.opacity)
                  }
              }
              .onAppear(perform: startLaunchSequence)
//              The .animation modifier is applied to the Group that contains all your conditional views. This will ensure that changes to isActive and isOnboardingComplete are animated.
              .animation(.easeInOut(duration: 1.0), value: isActive)
              .animation(.easeInOut(duration: 1.0), value: isOnboardingComplete)
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
