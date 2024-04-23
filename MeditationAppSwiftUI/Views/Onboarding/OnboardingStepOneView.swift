//
//  OnboardingStepView.swift
//  MeditationAppSwiftUI
//
//  Created by Bartek Daniel on 4/22/24.
//

import SwiftUI

struct OnboardingStepOneView: View {
    @State private var selectedPage = 0
    
//    The onNext: () -> Void is neither a @State nor a @Binding because it's a closure that is meant to be passed down from a parent view to the child view. It's a function that the child will call when a certain event happens (like tapping the "Next" button), signaling the parent view to take some action. This pattern is commonly used in SwiftUI for communication from child views back to parent views.
    
    var onNext: () -> Void
    
    var body: some View {
        VStack {
            Spacer()
            //here we create a TabView with two pages each represeting a OnboardingPageView
            TabView(selection: $selectedPage) {
                OnboardingPageViewOne(title: "AI generated\n5 - Min meditations", description: "Lorem ipsum dolor sit amet, consecteur adipiscing elit.", imageName: "your-image-1")
                    .tag(0)
                OnboardingPageViewOne(title: "Core benefits and value for user", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.", imageName: "your-image-2")
                    .tag(1)
            }
            .background(Color.gray)
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .frame(height: 470) // Adjust height as needed
            //to set views based on screen size
//            GeometryReader { geometry in
//                TabView(selection: $selectedPage) {
//                    // Your content here
//                }
//                .frame(height: geometry.size.height * 0.5) // Takes 50% of the available height
//            }
            
            Spacer()
            PageControl(numberOfPages: 2, currentPage: $selectedPage)
                .background(Color.gray)
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
                Text(selectedPage < 1 ? "Next" : "Get Started")
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding()
                    .background(Color.gray.opacity(0.2)) // Use your app's color scheme
                    .cornerRadius(10)
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
                
            // No alignment specified for Rectangle, so it stays centered within its VStack
        }
        .padding(.horizontal, 32)
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
