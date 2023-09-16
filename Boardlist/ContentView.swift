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
    
    // filter sheet controller
    @State private var isFiltersActive = false
    @State private var filterSheetHeight: CGFloat = .zero
    
    // focus state to control search text field
    @FocusState private var searchFieldIsFocused: Bool
    
    var searchResults: [Boards] {
        let segmentedBoards = isFavourited ? boards.filter{favourites.contains($0)} : boards
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
                
                if isFavourited && favourites.isEmpty() {
                    EmptyFavouritesView()
                }
                
                    ScrollView {
                        LazyVGrid(columns: columns) {
                            
                            HStack{
                                ZStack {
                                    HStack {
                                        Image(systemName: "magnifyingglass")
                                            .foregroundColor(.gray)
                                        TextField("Find your board here", text: $searchText)
                                            .focused($searchFieldIsFocused)
                                        
                                        if searchText != "" {
                                            Spacer()
                                            Button {
                                                searchText = ""
                                            } label: {
                                                Image(systemName: "xmark.circle.fill")
                                                    .foregroundColor(.gray)
                                            }
                                        }
                                    }
                                    .padding(8)
                                    .background(.thinMaterial.opacity(0.6))
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                    
                                    RoundedRectangle(cornerRadius: 10).stroke(.ultraThinMaterial)
                                        .allowsHitTesting(false)
                                }
                                .padding(.bottom, 8)
                                
                                if searchFieldIsFocused {
                                    Button("Cancel") {
                                        searchFieldIsFocused = false
                                        searchText = ""
                                    }
                                    .padding(.horizontal, 6)
                                    .padding(.vertical, 2)
                                }
                            }
                            
                            ForEach(searchResults) { board in
                                NavigationLink {
                                    
                                } label: {
                                    
                                    VStack(alignment: .leading, spacing: 14) {
                                        
                                         //Board brand, model and rating
                                        
                                        VStack(alignment: .leading) {
                                            HStack(alignment: .top) {
                                                HStack{
                                                    ZStack {
                                                        RoundedRectangle(cornerRadius: 8)
                                                            .fill(.blue)
                                                            .frame(width: 100, height: 100)
                                                            .padding(.top)
                                                            .padding(.trailing, 8)
                                                        
                                                        VStack(alignment: .trailing) {
                                                            Spacer()
                                                            HStack {
                                                                Text(board.boardType)
                                                                    .font(.footnote)
                                                                    .foregroundColor(.white)
                                                                    .padding(.vertical, 6)
                                                                    .padding(.horizontal, 10)
                                                                    .background(.ultraThinMaterial)
                                                                    .cornerRadius(16)
                                                                
                                                                Spacer()
                                                            }
                                                            .padding(4)
                                                        }
                                                        .frame(width: 106, height: 116)
                                                    }
                                                    
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
                                                            Text("(+50)")
                                                                .foregroundColor(.white.opacity(0.3))
                                                        }
                                                    }
                                                    .padding(.top, 12)
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
                                                        .foregroundColor(.blue)
                                                }
                                                .font(.title2)
                                                .padding(.top, 20)
                                            }
                                            
                                            
                                            Divider()
                                                .frame(height: 1.4)
                                                .overlay(.ultraThinMaterial)
                                                .padding(.top, 4)
                                                .padding(.bottom)
                                            
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
                
                // Small bottom gradient behind toolbar
                VStack {
                    Spacer()
                    VStack {
                        LinearGradient(colors: [Color(#colorLiteral(red: 0, green: 0.08004814165, blue: 0.1161996114, alpha: 1)), Color(#colorLiteral(red: 0, green: 0.02060918883, blue: 0.02991674364, alpha: 0))], startPoint: .bottom, endPoint: .top).ignoresSafeArea()
                    }
                    .frame(height: 70)
                }
                .allowsHitTesting(false)
                
                // Favourites and Filter toolbar
                
                VStack {
                    Spacer()
                    HStack(spacing: 24) {
                        VStack {
                            Button {
                                withAnimation {
                                    isFavourited.toggle()
                                }
                            } label: {
                                Image(systemName: isFavourited ? "heart.fill" : "heart")
                                    .foregroundColor(.white)
                            }
                            .font(.largeTitle)
                        }
                        
                        VStack {
                            Button {
                                isFiltersActive = true
                            } label: {
                                Image(systemName: "slider.horizontal.3")
                                    .foregroundColor(.white)
                            }
                            .font(.largeTitle)
                        }
                    }
                    .frame(height: 56)
                    .padding(.horizontal)
                    .background(.ultraThinMaterial)
                    .clipShape(Capsule())
                    .overlay(Capsule().stroke(.ultraThinMaterial))
                }
                .padding(.bottom, 8)
            }
        }
        .environmentObject(favourites)
        .sheet(isPresented: $isFiltersActive) {
            FilterSheetView()
                .overlay {
                    GeometryReader { geometry in
                        Color.clear.preference(key: InnerHeightPreferenceKey.self, value: geometry.size.height)
                    }
                }
                .onPreferenceChange(InnerHeightPreferenceKey.self) { newHeight in
                    filterSheetHeight = newHeight
                }
                .presentationDetents([.height(filterSheetHeight)])
                .presentationDragIndicator(.visible)
        }
    }
}

struct InnerHeightPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = .zero
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
