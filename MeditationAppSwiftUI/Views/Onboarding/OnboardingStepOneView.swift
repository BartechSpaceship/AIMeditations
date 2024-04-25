//
//  OnboardingStepView.swift
//  MeditationAppSwiftUI
//
//  Created by Bartek Daniel on 4/22/24.
//

import SwiftUI

struct OnboardingStepOneView: View {
    @State private var selectedPage = 0
    
    var onNext: () -> Void
    
    @State private var descriptionOne = "Reconnect with yourself through meditation sessions that cater to your life's rhythms"
    
    var body: some View {
        VStack {
            Spacer()
            //here we create a TabView with two pages each represeting a OnboardingPageView
            TabView(selection: $selectedPage) {
                OnboardingPageViewOne(title: "Mindful Moments\nguided by AI", description: descriptionOne, imageName: "your-image-1")
                    .tag(0)
                OnboardingPageViewOne(title: "Lorem ipsum sit dolor achmet tu sant", description: "Meditations for every moment", imageName: "your-image-2")
                    .tag(1)
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
             
            
             
            Spacer()
            Button(action: {
                if selectedPage < 1 {
                    // This will 'animate' the next page
                    withAnimation(.easeOut(duration: 0.5)) {
                        selectedPage += 1
                    }
                } else {
                    onNext()
                    // Here you handle the action for when the user is on the last page
                    // For example, advance to the next step of onboarding
                }
                
            }) {
                Image(systemName: "arrowshape.forward.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.gray)
                    .frame(width: 54, height: 54)
            }
         
            .padding(.all)
            Spacer()
        }
    }
}

struct OnboardingPageViewOne: View {
    let title: String
    let description: String
    let imageName: String
    
    var body: some View {
        VStack {
            Spacer()
            // Align the text to the left using frame alignment
            Text(title)
                .font(.title)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .leading)  // Forces the text to align left
            
            Spacer()
            
            Text(description)
                .frame(maxWidth: .infinity, alignment: .leading)  // Aligns the description text to the left
            Spacer()
        
            
            // Keep the Rectangle centered
            Rectangle()
                .fill(Color.secondary)
                .aspectRatio(1, contentMode: .fit)
                .overlay(
                    Text("Image Placeholder")
                        .foregroundColor(.white)
                )
                
            Spacer()
            Spacer()
            Spacer()
            // No alignment specified for Rectangle, so it stays centered within its VStack
        }
        .padding(.horizontal, 16)
        
//        .padding()  // Optionally add padding around the VStack content
    }
}

//The pages themselves
struct PageControl: UIViewRepresentable {
    var numberOfPages: Int
    @Binding var currentPage: Int
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: Context) -> UIPageControl {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = numberOfPages
        pageControl.addTarget(context.coordinator, action: #selector(Coordinator.updateCurrentPage(sender:)), for: .valueChanged)
        return pageControl
    }
    
    func updateUIView(_ uiView: UIPageControl, context: Context) {
        uiView.currentPage = currentPage
    }
    
    class Coordinator: NSObject {
        var control: PageControl
        
        init(_ control: PageControl) {
            self.control = control
        }
        
        @objc func updateCurrentPage(sender: UIPageControl) {
            control.currentPage = sender.currentPage
        }
    }
}

#Preview {
    OnboardingStepOneView(onNext: {})
}
