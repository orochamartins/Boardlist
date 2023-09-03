//
//  RatingView.swift
//  Boardlist
//
//  Created by Renato Martins on 03/09/2023.
//

import SwiftUI

struct RatingView: View {
    
    var rating: Int
    
    var offImage : Image?
    var onImage = Image(systemName: "star.fill")
    
    var offColor = Color.gray.opacity(0.4)
    var onColor = Color.yellow
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(1...5, id: \.self) { number in
                image(for: number)
                    .foregroundColor(number > rating ? offColor : onColor)
            }
        }
    }
    
    func image(for number: Int) -> Image {
        if number > rating {
            return offImage ?? onImage
        } else {
            return onImage
        }
    }
}

struct RatingView_Previews: PreviewProvider {
    static var previews: some View {
        RatingView(rating: 4)
    }
}
