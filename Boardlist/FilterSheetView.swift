//
//  FilterSheetView.swift
//  Boardlist
//
//  Created by Renato Martins on 14/09/2023.
//

import SwiftUI

struct FilterSheetView: View {
    
    @Environment(\.dismiss) var dismiss
    
    // Brand filter settings
    let brandList = ["All", "Chris Christenson", "Album", "Channel Islands", "Sharpeye"]
    @State private var selectedBrand = "All"
    
    // Material filter settings
    let materialList = ["All", "Soft-top", "Wood", "Polyurethane", "Epoxy"]
    @State private var selectedMaterial = "All"
    
    // Fin type filter settings
    let finTypeList = ["All", "Thruster", "Quad", "Twin", "Bonzer", "Single", "2+1", "1+2"]
    @State private var selectedFinType = "All"
    
    // Fin system filter settings
    let finSystemList = ["All", "FCS I", "FCS II", "Futures", "Glassed on"]
    @State private var selectedFinSystem = "All"
    
    // Tail type filter settings
    let tailTypeList = ["All", "Squashed", "Swallow", "Fish", "Diamond"]
    @State private var selectedTailType = "All"
    
    // Difficulty filter settings
    let difficultyList = ["All", "Beginner", "Intermediate", "Advanced", "Professional"]
    @State private var diffilcutyType = "All"
    
    var body: some View {
        VStack(spacing: 14) {
            FilterFieldView(pickerName: "Brand", selectedValue: selectedBrand, valuesArray: brandList)
            
            FilterFieldView(pickerName: "Material", selectedValue: selectedMaterial, valuesArray: materialList)
            
            FilterFieldView(pickerName: "Fin type", selectedValue: selectedFinType, valuesArray: finTypeList)
            
            FilterFieldView(pickerName: "Fin system", selectedValue: selectedFinSystem, valuesArray: finSystemList)
            
            FilterFieldView(pickerName: "Tail type", selectedValue: selectedTailType, valuesArray: tailTypeList)
            
            FilterFieldView(pickerName: "Difficulty", selectedValue: diffilcutyType, valuesArray: difficultyList)
            
                    
            Button {
                dismiss()
            } label: {
                Image(systemName: "triangle")
                Text("Apply filters")
            }
        }
        .padding(.horizontal)
    }
}

struct FilterSheetView_Previews: PreviewProvider {
    static var previews: some View {
        FilterSheetView()
            .preferredColorScheme(.dark)
    }
}
