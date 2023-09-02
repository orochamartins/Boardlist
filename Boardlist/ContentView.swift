//
//  ContentView.swift
//  Boardlist
//
//  Created by Renato Martins on 29/08/2023.
//

import SwiftUI

struct ContentView: View {
    
    let boards: [Boards] = Bundle.main.decode("boards.json")
    let columns = [GridItem(.adaptive(minimum: 300))]
    
    @State private var searchText = ""
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(colors: [Color(#colorLiteral(red: 0, green: 0.02060918883, blue: 0.02991674364, alpha: 1)), Color(#colorLiteral(red: 0, green: 0.08004814165, blue: 0.1161996114, alpha: 1))], startPoint: .top, endPoint: .bottom).ignoresSafeArea()
                
                ScrollView {
                    LazyVGrid(columns: columns) {
                        ForEach(boards) { board in
                            NavigationLink {
                                
                            } label: {
                                VStack(alignment: .leading, spacing: 14) {
                                    RoundedRectangle(cornerRadius: 8)
                                        .fill(.blue)
                                        .frame(height: 100)
                                        .padding([.horizontal, .top])
                                    HStack {
                                        VStack(alignment: .leading, spacing: 6) {
                                            Text(board.brand)
                                                .font(.headline)
                                                .foregroundColor(.primary.opacity(0.5))
                                            Text(board.model)
                                                .font(.title)
                                                .fontWeight(.bold)
                                                .foregroundColor(.white)
                                        }
                                        
                                        Spacer()
                                    }
                                    .frame(maxWidth: .infinity)
                                    .padding([.horizontal, .bottom])
                                }
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .overlay(RoundedRectangle(cornerRadius: 10).stroke(.ultraThinMaterial))
                                .padding(.bottom, 8)
                            }
                        }
                    }
                    .padding([.horizontal, .bottom])
                }
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        HStack {
                            Image(systemName: "triangle")
                            Text("Boardlist")
                        }
                    }
                }
                .preferredColorScheme(.dark)
                .navigationBarTitleDisplayMode(.inline)
            }
        }
        .searchable(text: $searchText, prompt: "Find your board here")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
