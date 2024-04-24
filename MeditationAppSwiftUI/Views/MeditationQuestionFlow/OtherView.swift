//
//  OtherView.swift
//  MeditationAppSwiftUI
//
//  Created by Bartek Daniel on 4/24/24.
//

import SwiftUI

struct OtherView: View {
    @Binding var selectedView: String
    @Binding var customAnswerText: String
    @Binding var questionTitle: String
    @Binding var questionNumber: Int
    
    var onSubmit: () -> Void
    
    var body: some View {
        VStack {
            Text(questionTitle)
                .font(.system(size: 32))
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 24)
                .padding(.horizontal, 16)
            
            
            
            ZStack() {
                ZStack(alignment: .topLeading){
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.D9D9D9_40Opacity)
                        .shadow(color: Color.gray.opacity(0.4), radius: 4, x: 0, y: 2)
                    
                    
                    if customAnswerText.isEmpty {
                        Text("Type Here")
                            .foregroundColor(Color.color000000_60Opacity)
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                            .padding()
                    }
                    
                    TextField("", text: $customAnswerText)
                        .textContentType(.name)
                        .padding()
                        .foregroundColor(Color.color000000_60Opacity) // Set the color of the actual text
                        .background(Color.clear)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                        .keyboardType(.alphabet)
                        .submitLabel(.go)
                        .onSubmit {
                            switch questionNumber {
                            case 1: UserDefaults.standard.setValue(customAnswerText, forKey: UserDefaultsConstants.questionOneAnswer)
                            case 2: UserDefaults.standard.setValue(customAnswerText, forKey: UserDefaultsConstants.questionTwoAnswer)
                            case 3: UserDefaults.standard.setValue(customAnswerText, forKey: UserDefaultsConstants.questionThreeAnswer)
                            default:
                                print("error")
                            }
                            print($customAnswerText)
                            onSubmit()
                        }
                    
                    
                }
                
                HStack{
                    Spacer()
                    VStack{
                        Spacer()
                        Button(action: {
                            
                        }) {
                            HStack {
                                Text("Tap to speak")
                                    .foregroundColor(Color.color000000_60Opacity)
                                Image(systemName: "mic.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .foregroundColor(Color.black)
                                    .frame(width: 24, height: 24)
                                
                                
                            }
                        }
                        
                        .padding(.bottom, 16)
                        .padding(.horizontal, 16)
                    }
                }
                
            }
            
            
            .frame(height: UIScreen.main.bounds.height * 0.5)
            .padding(.horizontal, 16)
            Spacer()
            
            
        }
        .padding(.horizontal, 16)
        //        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    OtherView(
        selectedView: .constant("otherView"),
        customAnswerText: .constant(""),
        questionTitle: .constant(""),
        questionNumber: .constant(1))
    {
        print("onsubmit")
    }
}
