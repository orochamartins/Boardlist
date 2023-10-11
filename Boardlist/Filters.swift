//
//  Filters.swift
//  Boardlist
//
//  Created by Renato Martins on 28/09/2023.
//

import Foundation

class Filters: ObservableObject {
    
    var filteredOptions = ["All"]
    
    // Brand filter settings
    let brandList = ["All", "Chris Christenson", "Album", "Channel Islands", "Sharpeye"]
    @Published var selectedBrand = "All"
    
    // Material filter settings
    let materialList = ["All", "Soft-top", "Wood", "Polyurethane", "Epoxy"]
    @Published var selectedMaterial = "All"
    
    // Fin type filter settings
    let finTypeList = ["All", "Thruster", "Quad", "Twin", "Bonzer", "Single", "2+1", "1+2"]
    @Published var selectedFinType = "All"
    
    // Difficulty filter settings
    let difficultyList = ["All", "Beginner", "Intermediate", "Advanced", "Professional"]
    @Published var diffilcultyType = "All"
    
    // Wave size filter settings
    let waveSizeList = ["All", "Knee", "Head", "Overhead", "Double+"]
    @Published var waveSizeType = "All"
    
    // Wave power filter settings
    let wavePowerList = ["All", "Weak", "Medium", "Strong", "Barrels"]
    @Published var wavePowerType = "All"
    
    // Board type filter settings
    let boardTypeList = ["All", "Fun", "Fish", "Short", "Mid", "Long", "Gun"]
    @Published var boardType = "All"
    
    // Apply filters function
    func apply() {
        objectWillChange.send()
        filteredOptions = [selectedBrand, boardType, selectedMaterial, selectedFinType, diffilcultyType, waveSizeType, wavePowerType]
    }
    
    // Clear filters function
    func clear() {
        objectWillChange.send()
        selectedBrand = "All"
        selectedMaterial = "All"
        selectedFinType = "All"
        diffilcultyType = "All"
        waveSizeType = "All"
        wavePowerType = "All"
        boardType = "All"
        filteredOptions = ["All"]
    }
}
