//
//  ReviewsScrollView.swift
//  Boardlist
//
//  Created by Renato Martins on 25/09/2023.
//

import SwiftUI

struct ReviewsScrollView: View {
    
    let board: Boards
    
    var body: some View {
        VStack {
            GeometryReader { geo in
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack (spacing: 16) {
                        ForEach(board.userReview) { review in
                            VStack(alignment: .leading, spacing: 8) {
                                RatingView(rating: review.rating)
                                Text(review.location)
                                    .font(.footnote)
                                    .foregroundColor(.white.opacity(0.5))
                                Text(review.description)
                                    .foregroundColor(.white.opacity(0.5))
                                    .padding(.top, 6)
                            }
                            .padding(.horizontal, 8)
                            .frame(width: geo.size.width * 0.6, height: 150)
                            .background(.thinMaterial.opacity(0.6))
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(.ultraThinMaterial))
                        }
                    }
                    .padding(.horizontal)
                }
            }
        }
        .frame(height: 150)
    }
}

struct ReviewsScrollView_Previews: PreviewProvider {
    static var previews: some View {
        
        let boards: [Boards] = Bundle.main.decode("boards.json")
        
        ReviewsScrollView(board: boards[1])
            .preferredColorScheme(.dark)
    }
}
