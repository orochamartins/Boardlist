//
//  FilterFieldView.swift
//  Boardlist
//
//  Created by Renato Martins on 16/09/2023.
//

import SwiftUI

struct FilterFieldView: View {
    
    let pickerName: String
    @Binding var selectedValue: String
    let valuesArray: [String]
    
    
    var body: some View {
        ZStack {
            HStack {
                Text(pickerName)
                
                Spacer()
                
                Picker(pickerName, selection: $selectedValue) {
                    ForEach(valuesArray, id: \.self) {
                        Text($0)
                    }
                }
                .tint(.gray)
            }
            .frame(minHeight: 48)
            .padding(.horizontal)
            .background(.thinMaterial.opacity(0.6))
            .clipShape(RoundedRectangle(cornerRadius: 10))
            
            RoundedRectangle(cornerRadius: 10).stroke(.ultraThinMaterial)
                .allowsHitTesting(false)
        }
        .frame(height: 48)
    }
}

