//
//  ContentView.swift
//  MeditationAppSwiftUI
//
//  Created by Bartek Daniel on 4/21/24.
//

import SwiftUI


struct ContentView: View {
    
    @State private var showingMeditationQuestions = false
    @State private var meditationQuestionStep: MeditationQuestion = .question1
    @State private var isButtonDisabled = false
    
    var body: some View {
        ZStack(alignment: .top) {
 
            ZStack {
                if meditationQuestionStep == .question1 || meditationQuestionStep == .question2 || meditationQuestionStep == .question3 {
                    Button(action: {
                        self.meditationQuestionStep = .question1
                        self.showingMeditationQuestions = true
                        self.isButtonDisabled = true
                    }) {
                        Circle()
                            .frame(maxWidth: 300, maxHeight: 300)
                            .foregroundColor(Color.gray)
                    }
                    .disabled(isButtonDisabled)
                    
                    .fullScreenCover(isPresented: $showingMeditationQuestions) {
                        if self.meditationQuestionStep == .question1 {
                            MeditationQuestionOne(onDismiss: { showNext in
                                self.showingMeditationQuestions = false
                                if showNext {
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                                        self.meditationQuestionStep = .question2
                                        self.showingMeditationQuestions = true
                                    }
                                } else {
                                    isButtonDisabled = false
                                }
                            })
                        } else if self.meditationQuestionStep == .question2 {
                            MeditationQuestionTwo(onDismiss: { showNext in
                                self.showingMeditationQuestions = false
                                if showNext {
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                                        self.meditationQuestionStep = .question3
                                        self.showingMeditationQuestions = true
                                    }
                                } else {
                                    isButtonDisabled = false
                                }
                            })
                        } else if self.meditationQuestionStep == .question3 {
                            MeditationQuestionThree(onDismiss: { showNext in
                                self.showingMeditationQuestions = false
                                if showNext {
                                    self.meditationQuestionStep = .findingBestMeditation
                                    isButtonDisabled = false
                                } else {
                                    isButtonDisabled = false
                                }
                            })
                            
                            
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    
                } else if meditationQuestionStep == .findingBestMeditation {
                    
                    withAnimation {
                        FindingBestMeditation()
                            .transition(.opacity)
//                            .transition(.push(from: .trailing))
                            .onAppear {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                                    self.meditationQuestionStep = .beginMeditationCreation
                                }
                            }
                    }
                    
                } else if meditationQuestionStep == .beginMeditationCreation {
                    withAnimation {
                        BeginMeditationCreation()
                            .transition(.opacity)
                            
                    }
                }
            }
            .animation(.easeIn(duration: 0.3), value: meditationQuestionStep)
        }
    }
      
}

enum MeditationQuestion {
    case question1
    case question2
    case question3
    case findingBestMeditation
    case beginMeditationCreation
}

#Preview {
    ContentView()
}
