//
//  CardViewWithTitleAndDescription.swift
//  MeditationAppSwiftUI
//
//  Created by Bartek Daniel on 4/25/24.
//

import SwiftUI

struct CardViewWithTitleAndDescription: View {
    let listItem: BasicListWithNameAndDescription
    let onTap: (String) -> Void
    
    var body: some View {
        Button(action: {
            onTap(listItem.name)
        }) {
            VStack(alignment: .leading) {
                Text(listItem.name)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                     
                Spacer()
                    .frame(height: 3)
                   
                Text(listItem.description)
                    .font(.subheadline)
                    .foregroundColor(.black)
                
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color.D9D9D9_40Opacity)
            .cornerRadius(10)
//            .shadow(color: Color.black.opacity(0.2), radius: 4, x: 0, y: 2)
            .contentShape(Rectangle()) // Add this modifier
        }
        .buttonStyle(PlainButtonStyle()) // Add this modifier
    }
}

#Preview {
    CardViewWithTitleAndDescription(listItem: BasicListWithNameAndDescription(name: "Sample Guide", description: "Sample description")) { String in
        print("Guide tapped")
    }
}
