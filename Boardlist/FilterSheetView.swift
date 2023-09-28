//
//  FilterSheetView.swift
//  Boardlist
//
//  Created by Renato Martins on 14/09/2023.
//

import SwiftUI

struct FilterSheetView: View {
    
    @Environment(\.dismiss) var dismiss
    @StateObject var filters: Filters
    
    var body: some View {
        ZStack {
            
            LinearGradient(colors: [Color(#colorLiteral(red: 0, green: 0.02060918883, blue: 0.02991674364, alpha: 1)), Color(#colorLiteral(red: 0, green: 0.08004814165, blue: 0.1161996114, alpha: 1))], startPoint: .top, endPoint: .bottom).opacity(0.4).ignoresSafeArea()
            
            VStack(spacing: 24) {
                
                ZStack {
                    Text("Filters")
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .center)
                    
                    Button("Clear") {
                        filters.clear()
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                }
                .padding(.top)
                
                VStack {
                    Text("General")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    FilterFieldView(pickerName: "Brand", selectedValue: filters.selectedBrand, valuesArray: filters.brandList)
                    
                    FilterFieldView(pickerName: "Type", selectedValue: filters.boardType, valuesArray: filters.boardTypeList)
                }
                
                VStack {
                    Text("Technical")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    FilterFieldView(pickerName: "Material", selectedValue: filters.selectedMaterial, valuesArray: filters.materialList)
                    
                    FilterFieldView(pickerName: "Fins", selectedValue: filters.selectedFinType, valuesArray: filters.finTypeList)
                    
                }
                
                VStack {
                    
                    Text("Criteria")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    FilterFieldView(pickerName: "Difficulty", selectedValue: filters.diffilcultyType, valuesArray: filters.difficultyList)
                    
                    FilterFieldView(pickerName: "Wave size", selectedValue: filters.waveSizeType, valuesArray: filters.waveSizeList)
                    
                    FilterFieldView(pickerName: "Wave power", selectedValue: filters.wavePowerType, valuesArray: filters.wavePowerList)
                }
                
                
                Button {
                    dismiss()
                    filters.apply()
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
        FilterSheetView(filters: Filters())
            .preferredColorScheme(.dark)
    }
}
