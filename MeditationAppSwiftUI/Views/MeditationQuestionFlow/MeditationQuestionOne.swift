//
//  MeditationQuestionOne.swift
//  MeditationAppSwiftUI
//
//  Created by Bartek Daniel on 4/23/24.
//

import SwiftUI

struct MeditationQuestionOne: View {
    
    var onDismiss: (Bool) -> Void
 
    @State private var selectedView = "questionOne"
    @State private var customAnswerText = ""
    @State private var questionTitle = "What is your primary goal for meditating today?"
    @State private var questionNumber = 1
    
    let listOfGoals = [
        BasicListWithName(name: "Reduce stress or anxiety"),
        BasicListWithName(name: "Improve self awareness/mindfulness"),
        BasicListWithName(name: "Improve focus & attention span"),
        BasicListWithName(name: "Manage emotions and mood"),
        BasicListWithName(name: "Sleep better"),
        BasicListWithName(name: "Alleviate physical pain/discomfort"),
        BasicListWithName(name: "I just want to clear my mind"),
        BasicListWithName(name: "Other")
    ]
    
    
    var body: some View {
        ZStack {
            if selectedView == "questionOne" {
                VStack {
                    Text(questionTitle)
                        .font(.system(size: 24))
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, 24)
                        .padding(.horizontal, 16)
                    
                    List {
                        ForEach(listOfGoals) { listItem in
                            CardView(listItem: listItem) { selectedListItem in
                                print(listItem.name)
                                UserDefaults.standard.setValue(questionTitle, forKey: UserDefaultsConstants.questionOneQuestion)
                                if listItem.name != "Other" {
                                    UserDefaults.standard.setValue(listItem.name, forKey: UserDefaultsConstants.questionOneAnswer)
                                    handleItemSelected()
                                } else {
                                    selectedView = "otherView"
                                }
                            }
                            .listRowInsets(EdgeInsets(top: 1, leading: 16, bottom: 16, trailing: 16))
                            .listRowSeparator(.hidden)
                        }
                        
                        Color.clear
                            .frame(height: 200)
                            .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                    }
                    .listStyle(PlainListStyle())
                    .mask(
                        LinearGradient(gradient: Gradient(colors: [Color.white, Color.white, Color.clear]), startPoint: .top, endPoint: .bottom)
                    )
                }
                .padding(.horizontal, 16)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else if selectedView == "otherView" {
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
                            selectedView = "questionOne"
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
    MeditationQuestionOne { Bool in
        print("true")
    }
}
