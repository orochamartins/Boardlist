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
    
    @StateObject var favourites = Favourites()
    @State private var searchText = ""
    
    // property for the segmented control
    @State private var isFavourited = false
    
    var searchResults: [Boards] {
        var segmentedBoards = isFavourited ? boards.filter{favourites.contains($0)} : boards
        if searchText.isEmpty {
            return segmentedBoards
        } else {
            return segmentedBoards.filter { $0.brand.localizedCaseInsensitiveContains(searchText) || $0.model.localizedCaseInsensitiveContains(searchText) || $0.material.localizedCaseInsensitiveContains(searchText) || $0.finType.localizedCaseInsensitiveContains(searchText) || $0.boardType.localizedCaseInsensitiveContains(searchText) || $0.tailType.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(colors: [Color(#colorLiteral(red: 0, green: 0.02060918883, blue: 0.02991674364, alpha: 1)), Color(#colorLiteral(red: 0, green: 0.08004814165, blue: 0.1161996114, alpha: 1))], startPoint: .top, endPoint: .bottom).ignoresSafeArea()
                
                ScrollView {
                    LazyVGrid(columns: columns) {
                        VStack {
                            Picker("Placeholder", selection: $isFavourited.animation()) {
                                Text("All boards").tag(false)
                                Text("Favourites").tag(true)
                            }
                            .pickerStyle(.segmented)
                        }
                        .padding(.vertical, 8)
                        
                        ForEach(searchResults) { board in
                            NavigationLink {
                                
                            } label: {
                                VStack(alignment: .leading, spacing: 14) {
                                    
                                    //Board image with content
                                    
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 8)
                                            .fill(.blue)
                                            .frame(height: 100)
                                            .padding([.horizontal, .top])
                                        
                                        VStack(alignment: .trailing) {
                                            Spacer()
                                            HStack {
                                                Spacer()
                                                Text(board.boardType)
                                                    .font(.footnote)
                                                    .foregroundColor(.white)
                                                    .padding(.vertical, 6)
                                                    .padding(.horizontal, 10)
                                                    .background(.ultraThinMaterial)
                                                    .cornerRadius(16)
                                            }
                                            .padding(6)
                                        }
                                        .padding([.horizontal, .top])
                                    }
                                    
                                    //Board brand, model and rating
                                    
                                    VStack(alignment: .leading) {
                                        HStack(alignment: .top) {
                                            VStack(alignment: .leading, spacing: 6) {
                                                Text(board.brand)
                                                    .font(.headline)
                                                    .fontWeight(.regular)
                                                    .foregroundColor(.primary.opacity(0.5))
                                                Text(board.model)
                                                    .font(.title)
                                                    .fontWeight(.bold)
                                                    .foregroundColor(.white)
                                                HStack(alignment: .bottom) {
                                                    RatingView(rating: board.ratingTotal)
                                                    Text("(+50 reviews)")
                                                        .foregroundColor(.white.opacity(0.3))
                                                }
                                            }
                                            
                                            Spacer()
                                            
                                            Button {
                                                withAnimation {
                                                    if favourites.contains(board) {
                                                        favourites.remove(board)
                                                    } else {
                                                        favourites.add(board)
                                                    }
                                                }
                                            } label: {
                                                Image(systemName: favourites.contains(board) ? "heart.fill" : "heart")
                                                    .foregroundColor(favourites.contains(board) ? .red : .blue)
                                            }
                                            .font(.title2)
                                        }
                        
                                            
                                        Divider()
                                            .frame(height: 1.4)
                                            .overlay(.ultraThinMaterial)
                                            .padding(.vertical)
                                            
                                        HStack(alignment: .center) {
                                            GaugeView(value: board.difficulty)
                                            WaveGaugeView(value: board.waveRange)
                                            PowerGaugeView(value: board.powerRange)
                                        }
                                        .frame(maxWidth: .infinity)
                                    }
                                    .frame(maxWidth: .infinity)
                                    .padding([.horizontal, .bottom])
                                }
                                .background(.thinMaterial.opacity(0.6))
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
                
                LinearGradient(colors: [Color(#colorLiteral(red: 0, green: 0.08004814165, blue: 0.1161996114, alpha: 1)), Color(#colorLiteral(red: 0, green: 0.02060918883, blue: 0.02991674364, alpha: 0))], startPoint: .bottom, endPoint: UnitPoint(x: 0, y: 0.1)).ignoresSafeArea()
            }
        }
        .environmentObject(favourites)
        .searchable(text: $searchText.animation(), prompt: "Find your board here")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
