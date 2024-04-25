//
//  Guide.swift
//  MeditationAppSwiftUI
//
//  Created by Bartek Daniel on 4/23/24.
//

import Foundation

struct BasicListWithName: Identifiable {
    let id = UUID()
    let name: String
}

struct BasicListWithNameAndDescription: Identifiable {
    let id = UUID()
    let name: String
    let description: String
}
