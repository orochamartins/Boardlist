//
//  ImageScrollView.swift
//  Boardlist
//
//  Created by Renato Martins on 25/09/2023.
//

import SwiftUI

struct ImageScrollView: View {
    
    let board: Boards
    
    var body: some View {
        VStack {
            GeometryReader { geo in
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack (spacing: 16) {
                        ForEach(board.photos, id: \.self) { photo in
                            Image(photo)
                                .resizable()
                                .scaledToFill()
                                .frame(width: geo.size.width * 0.9, height: 250)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                        }
                    }
                    .padding(.top, 16)
                }
            }
        }
        .frame(height: 266)
    }
}

struct ImageScrollView_Previews: PreviewProvider {
    static var previews: some View {
        let boards: [Boards] = Bundle.main.decode("boards.json")
        
        ImageScrollView(board: boards[0])
    }
}
