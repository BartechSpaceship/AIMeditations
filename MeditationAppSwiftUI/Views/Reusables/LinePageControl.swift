//
//  LinePageControl.swift
//  MeditationAppSwiftUI
//
//  Created by Bartek Daniel on 4/22/24.
//

import SwiftUI

struct LinePageControl: View {
    var numberOfPages: Int
    var currentIndex: Int
    
    var body: some View {
        HStack {
            //here you can just do currentIndext == indext ? "25" : "1" to make it a dot or something 
            ForEach(0..<numberOfPages, id: \.self) { index in
                Rectangle()
                    .frame(width: 25, height: 4)
                    .foregroundColor(index == currentIndex ? .black : .gray)
                    .transition(.opacity)
                    .animation(.easeOut(duration: 0.2), value: currentIndex)
                    .cornerRadius(300)
            }
        }
    }
}

#Preview {
    LinePageControl(numberOfPages: 3, currentIndex: 0)
}
