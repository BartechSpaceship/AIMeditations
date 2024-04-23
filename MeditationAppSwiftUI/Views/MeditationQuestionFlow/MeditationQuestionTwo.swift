//
//  MeditationQuestionTwo.swift
//  MeditationAppSwiftUI
//
//  Created by Bartek Daniel on 4/23/24.
//

import SwiftUI

struct MeditationQuestionTwo: View {
    
    var onDismiss: (Bool) -> Void
    @State private var showingNextModal = false
    
    let listItems = [
        BasicListWithName(name: "Negative self-talk or criticsm"),
        BasicListWithName(name: "Anxious or worrying thoughts"),
        BasicListWithName(name: "Procrastination or avoidant behaviours"),
        BasicListWithName(name: "Emotional reactivity or impulsiveness"),
        BasicListWithName(name: "Other")
    ]
    
    @State private var title = "What aspect of your life would you like to be more mindful in?"
    
    var body: some View {
        ZStack {
            VStack {
                Text(title)
                    .font(.system(size: 24))
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 24)
                    .padding(.horizontal, 16)
                
                List(listItems) { listItem in
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
    MeditationQuestionTwo { Bool in
        print("text")
    }
}
