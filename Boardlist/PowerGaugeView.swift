//
//  PowerGaugeView.swift
//  Boardlist
//
//  Created by Renato Martins on 05/09/2023.
//

import SwiftUI

struct PowerGaugeView: View {
    
    let value: [Int]
    
    var body: some View {
        VStack(spacing: -4) {
            ZStack {
                Group {
                    Circle()
                        .trim(from: 0, to: 0.10)
                        .stroke(value[0]...value[1] ~= 1 ? getColor(from: 1) : .white.opacity(0.2), style: StrokeStyle(lineWidth: 6, lineCap: .round))
                        .frame(width: 45)
                        .rotationEffect(.degrees(-180))
                    
                    Circle()
                        .trim(from: 0, to: 0.10)
                        .stroke(value[0]...value[1] ~= 2 ? getColor(from: 2) : .white.opacity(0.2), style: StrokeStyle(lineWidth: 6, lineCap: .round))
                        .frame(width: 45)
                        .rotationEffect(.degrees(-122))
                    
                    Circle()
                        .trim(from: 0, to: 0.10)
                        .stroke(value[0]...value[1] ~= 3 ? getColor(from: 3) : .white.opacity(0.2), style: StrokeStyle(lineWidth: 6, lineCap: .round))
                        .frame(width: 45)
                        .rotationEffect(.degrees(-64))
                    
                    Circle()
                        .trim(from: 0, to: 0.10)
                        .stroke(value[0]...value[1] ~= 4 ? getColor(from: 4) : .white.opacity(0.2), style: StrokeStyle(lineWidth: 6, lineCap: .round))
                        .frame(width: 45)
                        .rotationEffect(.degrees(-6))
                }
                .rotationEffect(.degrees(-14))
                
                Image(systemName: "bolt.fill")
                    .foregroundColor(.white)
            }
            
            Text("\(getTitle(from: value[0])) \nto \(getTitle(from: value[1]))")
                .multilineTextAlignment(.center)
                .font(.caption)
                .foregroundColor(.white)
                .frame(maxWidth: 95)
        }
        .frame(maxWidth: .infinity)
    }
    
    func getColor(from value: Int) -> Color {
        switch value {
        case 1:
            return Color.cyan.opacity(0.8)
        case 2:
            return Color.blue
        case 3:
            return Color.indigo
        case 4:
            return Color.purple.opacity(0.8)
        default:
           return Color.white
        }
    }
    
    func getTitle(from value: Int) -> String {
        switch value {
        case 1:
            return "Weak"
        case 2:
            return "Medium"
        case 3:
            return "Strong"
        case 4:
           return "Barrels"
        default:
           return "Not disclosed"
        }
    }
}

struct PowerGaugeView_Previews: PreviewProvider {
    static var previews: some View {
        PowerGaugeView(value: [1, 4])
            .preferredColorScheme(.dark)
    }
}
