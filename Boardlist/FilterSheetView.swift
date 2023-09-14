//
//  FilterSheetView.swift
//  Boardlist
//
//  Created by Renato Martins on 14/09/2023.
//

import SwiftUI

struct FilterSheetView: View {
    
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
    
    var body: some View {
        VStack {
            
            Form {
                Picker("Brand", selection: $selectedBrand) {
                    ForEach(brandList, id: \.self) {
                        Text($0)
                    }
                }
                
                Picker("Material", selection: $selectedMaterial) {
                    ForEach(materialList, id: \.self) {
                        Text($0)
                    }
                }
                
                Picker("Fin type", selection: $selectedFinType) {
                    ForEach(finTypeList, id: \.self) {
                        Text($0)
                    }
                }
                
                Picker("Fin system", selection: $selectedFinSystem) {
                    ForEach(finSystemList, id: \.self) {
                        Text($0)
                    }
                }
            }
        }
    }
}

struct FilterSheetView_Previews: PreviewProvider {
    static var previews: some View {
        FilterSheetView()
            .preferredColorScheme(.dark)
    }
}
