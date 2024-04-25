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
    
    let guides = [
        BasicListWithName(name: "Jesus"),
        BasicListWithName(name: "Allah"),
        BasicListWithName(name: "Buddha"),
        BasicListWithName(name: "Ron"),
        BasicListWithName(name: "Jordan Peterson")
    ]
    let experience = [
        BasicListWithNameAndDescription(name: "No experience", description: "I've never meditated before"),
        BasicListWithNameAndDescription(name: "Newcomer", description: "Just starting out or curious about meditation"),
        BasicListWithNameAndDescription(name: "Casual", description: "Occasionally meditate and know the basics"),
        BasicListWithNameAndDescription(name: "Enthusiast", description: "I meditate regularly and have a consistent practice"),
        BasicListWithNameAndDescription(name: "Seasoned", description: "I have a deep understanding of meditation")
    ]
    
    //    var onFinish: () -> Void
    var onNext: () -> Void
    @State var progressPercentage: Float = 0.33
    @State var userName = ""
    
    
    var body: some View {
        VStack {
            ProgressView(value: progressPercentage)
                .progressViewStyle(LinearProgressViewStyle())
                .tint(.gray)
                .cornerRadius(0)
                .frame(maxWidth: .infinity ,maxHeight: 24, alignment: .center)
                .padding(.horizontal, -3)
                .edgesIgnoringSafeArea(.horizontal)
            
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
            
            HStack {
                Button(action: {
                    withAnimation(.easeInOut(duration: 0.5)) {
                        if currentPage == 2 {
                            onNext()
                        } else {
                            currentPage += 1
                        }
                        setProgressPercentage()
                    }
                }) {
                    Text("Skip")
                        .frame(width: 40)
                        .foregroundColor(.black)
                        .fontWeight(.bold)
                }
                .frame(width: 60, alignment: .leading)
                
                Spacer()
                
                Button(action: {
                    //Todo implement logic if next button is clicked check if item is selected
                    if currentPage == 2 {
                        onNext()
                    } else {
                        currentPage += 1
                    }
                    
                    setProgressPercentage()
                }) {
                    Image(systemName: "arrowshape.forward.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .foregroundColor(.gray)
                        .frame(width: 54, height: 54)
                }
                .frame(width: 60, alignment: .trailing)
                 
            }
            .padding(.horizontal, 32)
            .padding(.bottom, 32)
           
            
            
        }
    }
    
    private func setProgressPercentage(){
        if currentPage == 0 {
            progressPercentage = 0.33
        } else if currentPage == 1 {
            progressPercentage = 0.66
        } else if currentPage == 2 {
            progressPercentage = 0.99
        }
    }
    
    // This is a computed property, it can not own a persistent state
    private var firstPageView: some View {
        
        // State to hold the input text
        VStack {
            Text("Welcome, I'm (name)")
                .background(Color.white)
                .font(.title)
                .fontWeight(.heavy)
                .frame(maxWidth: .infinity, alignment: .topLeading)
                .padding(.top, 24)
            
            Spacer().frame(height: 8)
            
            Text("What would you like to be called?")
                .background(Color.white)
                .font(.subheadline)
                .fontWeight(.regular)
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
        .padding(.horizontal, 16)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    
    
    //    private var firstPageView: some View
    private var secondPageView: some View {
        
        VStack {
            Text("Who would you like as your guide?")
                .font(.title)
                .fontWeight(.heavy)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 24)
                 
            Text("You can change later")
                .font(.subheadline)
                .fontWeight(.regular)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            
            List(guides) { guide in
                CardView(listItem: guide) { selectedGuideName in
                    UserDefaults.standard.set(selectedGuideName, forKey: UserDefaultsConstants.guideName)
                    print("Guide Name \(UserDefaults.standard.string(forKey: UserDefaultsConstants.guideName) ?? "")")
                    currentPage += 1
                }
                .listRowInsets(EdgeInsets(top: 1, leading: 0, bottom: 16, trailing: 0))
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
                .font(.title)
                .fontWeight(.heavy)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 24)
               
               
             
            List(experience) { guide in
                CardViewWithTitleAndDescription(listItem: guide) { selectedGuideName in
                    UserDefaults.standard.set(selectedGuideName, forKey: UserDefaultsConstants.experienceLevel)
                    print("Guide Name \(UserDefaults.standard.string(forKey: UserDefaultsConstants.experienceLevel) ?? "")")
                    onNext()
                }
                .listRowInsets(EdgeInsets(top: 1, leading: 0, bottom: 16, trailing: 0))
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
    OnboardingStepTwoView(onNext: {print("nothing")}, progressPercentage: 0.33)
    //    OnboardingStepTwoView {
    //        print("next")
    //    }
}
