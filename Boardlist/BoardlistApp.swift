//
//  BoardlistApp.swift
//  Boardlist
//
//  Created by Renato Martins on 29/08/2023.
//

import SwiftUI

@main
struct BoardlistApp: App {
    var body: some Scene {
        let filteredOptions = [String]()
        WindowGroup {
            ContentView(filteredOptions: .constant(filteredOptions))
        }
    }
}
