//
//  CardView.swift
//  MeditationAppSwiftUI
//
//  Created by Bartek Daniel on 4/23/24.
//

import SwiftUI


struct CardView: View {
    let listItem: BasicListWithName
    let onTap: (String) -> Void
    
    var body: some View {
        Button(action: {
            onTap(listItem.name)
        }) {
            VStack(alignment: .leading) {
                Text(listItem.name)
                    .font(.system(size: 20))
                    .foregroundColor(.black)
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .background(Color.white)
            .cornerRadius(10)
            .shadow(color: Color.black.opacity(0.2), radius: 4, x: 0, y: 2)
            .contentShape(Rectangle()) // Add this modifier
        }
        .buttonStyle(PlainButtonStyle()) // Add this modifier
    }
}

#Preview {
    CardView(listItem: BasicListWithName(name: "Sample Guide")) { String in
        print("Guide tapped")
    }
}
