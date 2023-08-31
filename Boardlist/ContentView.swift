//
//  ContentView.swift
//  Boardlist
//
//  Created by Renato Martins on 29/08/2023.
//

import SwiftUI

struct ContentView: View {
    
    let boards: [Boards] = Bundle.main.decode("boards.json")
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(colors: [Color(#colorLiteral(red: 0, green: 0.02060918883, blue: 0.02991674364, alpha: 1)), Color(#colorLiteral(red: 0, green: 0.08004814165, blue: 0.1161996114, alpha: 1))], startPoint: .top, endPoint: .bottom).ignoresSafeArea()
                
                ScrollView {
                    LazyVGrid(columns: columns) {
                        ForEach(boards) { board in
                            NavigationLink {
                                
                            } label: {
                                VStack {
                                    Circle()
                                        .fill(.blue)
                                        .frame(width: 100, height: 100)
                                        .padding()
                                    VStack(alignment: .leading, spacing: 6) {
                                        Text(board.brand)
                                            .font(.caption)
                                            .foregroundColor(.primary.opacity(0.5))
                                        Text(board.model)
                                            .font(.headline)
                                            .foregroundColor(.white)
                                    }
                                    .frame(maxWidth: .infinity)
                                    .padding(.bottom)
                                }
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .overlay(RoundedRectangle(cornerRadius: 10).stroke(.white.opacity(0.3)))
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
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
