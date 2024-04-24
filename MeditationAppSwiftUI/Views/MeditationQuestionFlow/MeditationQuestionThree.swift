//
//  MeditationQuestionThree.swift
//  MeditationAppSwiftUI
//
//  Created by Bartek Daniel on 4/23/24.
//

import SwiftUI

struct MeditationQuestionThree: View {
    
    
    var onDismiss: (Bool) -> Void
    @State private var selectedView = "questionThree"
    @State private var customAnswerText = ""
    @State private var questionTitle = "What bests describes your current environment or physical state?"
    @State private var questionNumber = 3
    
    let listItems = [
        BasicListWithName(name: "Sitting comfortably"),
        BasicListWithName(name: "Lying down"),
        BasicListWithName(name: "Walking or on the go"),
        BasicListWithName(name: "Other")
    ]
    
     
    var body: some View {
        ZStack {
            if selectedView == "questionThree"{
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
                            UserDefaults.standard.setValue(questionTitle, forKey: UserDefaultsConstants.questionThreeQuestion)
                            if listItem.name == "Other" {
                                selectedView = "otherView"
                            } else {
                                UserDefaults.standard.setValue(listItem.name, forKey: UserDefaultsConstants.questionThreeAnswer)
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
                            selectedView = "questionThree"
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
    MeditationQuestionThree{ Bool in
        print("text")
    }
}
