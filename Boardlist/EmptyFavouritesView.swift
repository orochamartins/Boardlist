//
//  EmptyFavouritesView.swift
//  Boardlist
//
//  Created by Renato Martins on 14/09/2023.
//

import SwiftUI

struct EmptyFavouritesView: View {
    var body: some View {
        VStack(alignment: .center, spacing: 8) {
            Image(systemName: "heart.slash")
                .font(.system(size: 48))
                .foregroundColor(.blue)
                .padding(.bottom, 6)
            Text("There's no favourite boards")
                .font(.title2)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
            Text("Looks like you didn't add any boards as favourites. Go back to the list and start adding boards.")
                .opacity(0.6)
                .multilineTextAlignment(.center)
        }
        .padding(32)
    }
}

struct EmptyFavouritesView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyFavouritesView()
            .preferredColorScheme(.dark)
    }
}
