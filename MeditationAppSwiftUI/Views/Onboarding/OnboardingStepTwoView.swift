//
//  OnboardingStepTwoView.swift
//  MeditationAppSwiftUI
//
//  Created by Bartek Daniel on 4/22/24.
//

import SwiftUI



struct OnboardingStepTwoView: View {
    @State private var currentPage = 0
    @State private var transitioningForward = true
    @AppStorage(UserDefaultsConstants.userName) private var name: String = ""
    @State private var text = ""
    
    let guides = [BasicListWithName(name: "Jesus"), BasicListWithName(name: "Allah"), BasicListWithName(name: "Buddha"), BasicListWithName(name: "Ron"), BasicListWithName(name: "Jordan Peterson")]
    let experience = [BasicListWithName(name: "None"), BasicListWithName(name: "Beginner"), BasicListWithName(name: "Intermediate"), BasicListWithName(name: "Advanced"), BasicListWithName(name: "I am one with meditation")]
    
    //    var onFinish: () -> Void
    var onNext: () -> Void
    
    
    var body: some View {
        VStack {
            
            HStack {
                Button(action: {
                    currentPage -= 1
                    
                }) {
                    Image(systemName: "arrow.left")
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(.black)
                        .frame(width: 24, height: 24)
                }
                .frame(width: 60, alignment: .leading)
                
                Spacer()
                
                LinePageControl(numberOfPages: 3, currentIndex: currentPage)
                    .frame(maxHeight: .infinity, alignment: .center)
                
                Spacer()
                
                // Next button
                Button(action: {
                    withAnimation(.easeInOut(duration: 0.5)) {
                        if currentPage == 2 {
                            onNext()
                        } else {
                            currentPage += 1
                        }
                    }
                }) {
                    Text("SKIP")
                        .frame(width: 40)
                        .foregroundColor(.black)
                        .fontWeight(.bold)
                }
                .frame(width: 60, alignment: .trailing)
            }
            .frame(maxHeight: 24)
            .padding(.horizontal, 32)
            
            
            // Conditional views based on current page
            ZStack {
                switch currentPage {
                case 0:
                    firstPageView
                case 1:
                    secondPageView
                    
                case 2:
                    thirdPageView
                    
                default:
                    EmptyView()
                }
            }
            .animation(.easeOut, value: currentPage)
        }
    }
    
    // This is a computed property, it can not own a persistent state
    private var firstPageView: some View {
        
        // State to hold the input text
        VStack {
            Text("Welcome, I'm (name)")
                .background(Color.white)
                .font(.system(size: 32))
                .fontWeight(.heavy)
                .frame(maxWidth: .infinity, alignment: .topLeading)
                .padding(.top, 24)
            
            Spacer().frame(height: 8)
            
            Text("What would you like to be called?")
                .background(Color.white)
                .font(.system(size: 20))
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .topLeading)
            
            
            TextField("Enter name", text: $text) // The TextField for user input
                .textContentType(.name)
                .textFieldStyle(RoundedBorderTextFieldStyle()) // Removes the default TextField styling
                .padding(.vertical, 12)
                .font(.body)
                .keyboardType(.alphabet)
                .submitLabel(.go)
                .onSubmit {
                    name = text
                    currentPage += 1
                }
            
            
            Spacer()
        }
        .padding(.horizontal, 32)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    
    
    //    private var firstPageView: some View
    private var secondPageView: some View {
        
        VStack {
            Text("Who would you like as your guide?")
                .font(.system(size: 32))
                .fontWeight(.heavy)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 24)
                .padding(.horizontal, 16)
            
            Text("You can change later")
                .font(.system(size: 20))
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 16)
            
            
            List(guides) { guide in
                CardView(listItem: guide) { selectedGuideName in
                    UserDefaults.standard.set(selectedGuideName, forKey: UserDefaultsConstants.guideName)
                    print("Guide Name \(UserDefaults.standard.string(forKey: UserDefaultsConstants.guideName) ?? "")")
                    currentPage += 1
                }
                .listRowInsets(EdgeInsets(top: 1, leading: 16, bottom: 16, trailing: 16))
                .listRowSeparator(.hidden)
            }
            .listStyle(PlainListStyle())
            
            
            
            
        }
        .padding(.horizontal, 16)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        
        
    }
    
    private var thirdPageView: some View {
        
        
        VStack {
            Text("How much experience do you have with meditation")
                .font(.system(size: 32))
                .fontWeight(.heavy)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 24)
                .padding(.horizontal, 16)
            
            
            List(experience) { guide in
                CardView(listItem: guide) { selectedGuideName in
                    UserDefaults.standard.set(selectedGuideName, forKey: UserDefaultsConstants.experienceLevel)
                    print("Guide Name \(UserDefaults.standard.string(forKey: UserDefaultsConstants.experienceLevel) ?? "")")
                    onNext()
                }
                .listRowInsets(EdgeInsets(top: 1, leading: 16, bottom: 16, trailing: 16))
                .listRowSeparator(.hidden)
            }
            .listStyle(PlainListStyle())
            
            Spacer()
        }
        .padding(.horizontal, 16)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
        
    }
    
    
}


#Preview {
    OnboardingStepTwoView {
        print("next")
    }
}
