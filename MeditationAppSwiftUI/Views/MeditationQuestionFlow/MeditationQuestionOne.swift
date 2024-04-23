//
//  MeditationQuestionOne.swift
//  MeditationAppSwiftUI
//
//  Created by Bartek Daniel on 4/23/24.
//

import SwiftUI

struct MeditationQuestionOne: View {
    
    var onDismiss: (Bool) -> Void
    @State private var showingNextModal = false
    
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
            VStack {
                Text("What is your primary goal for meditating today?")
                    .font(.system(size: 24))
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 24)
                    .padding(.horizontal, 16)
                
                List(listOfGoals) { listItem in
                    CardView(listItem: listItem) { selectedListItem in
                        print(listItem.name)
                        UserDefaults.standard.setValue(UserDefaultsConstants.experienceLevel, forKey: listItem.name)
                        handleItemSelected()
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
            
            VStack {
                Spacer()
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
            }
        }
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
