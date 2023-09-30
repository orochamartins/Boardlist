//
//  EmptySearchView.swift
//  Boardlist
//
//  Created by Renato Martins on 30/09/2023.
//

import SwiftUI

struct EmptySearchView: View {
    var body: some View {
        VStack(alignment: .center, spacing: 8) {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 48))
                .foregroundColor(.blue)
                .padding(.bottom, 6)
            Text("No results found...")
                .font(.title2)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
            Text("There's no boards in our database according to your search and filter options. Choose other options and try again.")
                .opacity(0.6)
                .multilineTextAlignment(.center)
        }
        .padding(32)
    }
}

struct EmptySearchView_Previews: PreviewProvider {
    static var previews: some View {
        EmptySearchView()
            .preferredColorScheme(.dark)
    }
}
