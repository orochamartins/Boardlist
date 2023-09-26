//
//  FilterSheetView.swift
//  Boardlist
//
//  Created by Renato Martins on 14/09/2023.
//

import SwiftUI

struct FilterSheetView: View {
    
    @Environment(\.dismiss) var dismiss
    @State private var filteredOptions = ["All", "All", "All", "All", "All", "All", "All"]
    
    // Brand filter settings
    let brandList = ["All", "Chris Christenson", "Album", "Channel Islands", "Sharpeye"]
    @State private var selectedBrand = "All"
    
    // Material filter settings
    let materialList = ["All", "Soft-top", "Wood", "Polyurethane", "Epoxy"]
    @State private var selectedMaterial = "All"
    
    // Fin type filter settings
    let finTypeList = ["All", "Thruster", "Quad", "Twin", "Bonzer", "Single", "2+1", "1+2"]
    @State private var selectedFinType = "All"
    
    // Difficulty filter settings
    let difficultyList = ["All", "Beginner", "Intermediate", "Advanced", "Professional"]
    @State private var diffilcultyType = "All"
    
    // Wave size filter settings
    let waveSizeList = ["All", "Knee", "Head", "Overhead", "Double+"]
    @State private var waveSizeType = "All"
    
    // Wave power filter settings
    let wavePowerList = ["All", "Weak", "Medium", "Strong", "Barrels"]
    @State private var wavePowerType = "All"
    
    // Board type filter settings
    let boardTypeList = ["All", "Funboard", "Fish", "Shortboard", "Midlength", "Longboard", "Gun"]
    @State private var boardType = "All"
    
    var body: some View {
        ZStack {
            
            LinearGradient(colors: [Color(#colorLiteral(red: 0, green: 0.02060918883, blue: 0.02991674364, alpha: 1)), Color(#colorLiteral(red: 0, green: 0.08004814165, blue: 0.1161996114, alpha: 1))], startPoint: .top, endPoint: .bottom).opacity(0.4).ignoresSafeArea()
            
            VStack(spacing: 24) {
                
                ZStack {
                    Text("Filters")
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .center)
                    
                    Button("Clear") {
                        selectedBrand = "All"
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                }
                .padding(.top)
                
                VStack {
                    Text("General")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    FilterFieldView(pickerName: "Brand", selectedValue: selectedBrand, valuesArray: brandList)
                    
                    FilterFieldView(pickerName: "Type", selectedValue: boardType, valuesArray: boardTypeList)
                }
                
                VStack {
                    Text("Technical")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    FilterFieldView(pickerName: "Material", selectedValue: selectedMaterial, valuesArray: materialList)
                    
                    FilterFieldView(pickerName: "Fins", selectedValue: selectedFinType, valuesArray: finTypeList)
                    
                }
                
                VStack {
                    
                    Text("Criteria")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    FilterFieldView(pickerName: "Difficulty", selectedValue: diffilcultyType, valuesArray: difficultyList)
                    
                    FilterFieldView(pickerName: "Wave size", selectedValue: waveSizeType, valuesArray: waveSizeList)
                    
                    FilterFieldView(pickerName: "Wave power", selectedValue: wavePowerType, valuesArray: wavePowerList)
                }
                
                
                Button {
                    dismiss()
                    filteredOptions = [selectedBrand, boardType, selectedMaterial, selectedFinType, diffilcultyType, waveSizeType, wavePowerType]
                } label: {
                    Image(systemName: "checkmark.circle")
                    Text("Apply filters")
                }
                .frame(maxWidth: .infinity)
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .background(.blue)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .padding(.top, 8)
            }
            .padding()
        }
    }
}

struct FilterSheetView_Previews: PreviewProvider {
    static var previews: some View {
        FilterSheetView()
            .preferredColorScheme(.dark)
    }
}
