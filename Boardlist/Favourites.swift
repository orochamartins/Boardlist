//
//  Favourites.swift
//  Boardlist
//
//  Created by Renato Martins on 06/09/2023.
//

import SwiftUI

class Favourites: ObservableObject {
    
    // board the user has favourited
    private var favouriteBoards: Set<Int>
    
    // key value used to read/write in UserDefaults
    private let saveKey = "Favourites"
    
    init() {
        
        // load saved data
        if let data = UserDefaults.standard.data(forKey: saveKey) {
            if let decoded = try? JSONDecoder().decode(Set<Int>.self, from: data) {
                favouriteBoards = decoded
                return
            }
        }
        
        favouriteBoards = []
        
    }
    
    // returns true if our Set contains this board
    func contains(_ board: Boards) -> Bool {
        favouriteBoards.contains(board.id)
    }
    
    // adds the board to our set, updates all views, and saves the changes
    func add(_ board: Boards) {
        objectWillChange.send()
        favouriteBoards.insert(board.id)
        save()
    }
    
    // removes the board from our set, updates all views, and saves the changes
    func remove(_ board: Boards) {
        objectWillChange.send()
        favouriteBoards.remove(board.id)
        save()
    }
    
    func save() {
        if let encoded = try? JSONEncoder().encode(favouriteBoards) {
            UserDefaults.standard.set(encoded, forKey: saveKey)
        }
    }
    
}
