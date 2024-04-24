//
//  MeditationQuestionTwo.swift
//  MeditationAppSwiftUI
//
//  Created by Bartek Daniel on 4/23/24.
//

import SwiftUI

struct MeditationQuestionTwo: View {
    
    var onDismiss: (Bool) -> Void
    @State private var selectedView = "questionTwo"
    @State private var customAnswerText = ""
    @State private var questionTitle = "What aspect of your life would you like to be more mindful in?"
    @State private var questionNumber = 2
    
    let listItems = [
        BasicListWithName(name: "Negative self-talk or criticsm"),
        BasicListWithName(name: "Anxious or worrying thoughts"),
        BasicListWithName(name: "Procrastination or avoidant behaviours"),
        BasicListWithName(name: "Emotional reactivity or impulsiveness"),
        BasicListWithName(name: "Other")
    ]
    
    
    var body: some View {
        ZStack {
            if selectedView == "questionTwo"{
                VStack {
                    Text(questionTitle)
                        .font(.system(size: 24))
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, 24)
                        .padding(.horizontal, 16)
                    
                    List(listItems) { listItem in
                        CardView(listItem: listItem) { selectedListItem in
                            print(listItem.name)
                            UserDefaults.standard.setValue(questionTitle, forKey: UserDefaultsConstants.questionTwoQuestion)
                            if listItem.name == "Other" {
                                selectedView = "otherView"
                            } else {
                                UserDefaults.standard.setValue(listItem.name, forKey: UserDefaultsConstants.questionTwoAnswer)
                                handleItemSelected()
                            }
                           
                        }
                        .listRowInsets(EdgeInsets(top: 1, leading: 16, bottom: 16, trailing: 16))
                        .listRowSeparator(.hidden)
                    }
                    .listStyle(PlainListStyle())
                    .mask(
                        LinearGradient(gradient: Gradient(colors: [Color.white, Color.white, Color.clear]), startPoint: .top, endPoint: .bottom)
                    )
                }
                .padding(.horizontal, 16)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else if selectedView == "otherView"{
                withAnimation {
                    OtherView(
                        selectedView: $selectedView,
                        customAnswerText: $customAnswerText,
                        questionTitle: $questionTitle,
                        questionNumber: $questionNumber,
                        onSubmit:{ handleItemSelected()
                        })
                }.transition(.asymmetric(insertion: .move(edge: .bottom), removal: .move(edge: .bottom)))
            }
            
            VStack {
                Spacer()
                HStack {
                    if selectedView == "otherView" {
                        Button(action: {
                            selectedView = "questionTwo"
                        }) {
                            Image(systemName: "arrowshape.backward.circle")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .foregroundColor(.black)
                                .frame(width: 54, height: 54)
                        }
                        .padding(.bottom, 16)
                        .padding(.trailing, 16)
                    }
                    
                    Button(action: {
                        handleDismissButton()
                    }) {
                        Image(systemName: "xmark.circle")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(.black)
                            .frame(width: 54, height: 54)
                    }
                    .padding(.bottom, 16)
                    .padding(.leading, 16)
                }
            }
        }
        .animation(.easeIn(duration: 0.25), value: selectedView)
    }
    
    private func handleItemSelected(){
        self.onDismiss(true)// Dismiss the modal
        
    }
    
    private func handleDismissButton(){
        self.onDismiss(false)// Dismiss the modal
        
    }
    
    
}

#Preview {
    MeditationQuestionTwo { Bool in
        print("text")
    }
}
