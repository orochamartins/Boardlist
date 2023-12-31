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
    @ObservedObject var filters: Filters
    
    @State private var searchText = ""
    
    // property to check scroll position
    @State private var scrollPosition: CGPoint = .zero
    
    // property to check scroll changes
    @State private var hasScrolled = false
    
    // property to store top bar height
    @State private var topBarSize = 158
    
    // property for the segmented control
    @State private var isFavourited = false
    
    // filter sheet controller
    @State private var isFiltersActive = false
    @State private var filterSheetHeight: CGFloat = .zero
    
    // focus state to control search text field
    @FocusState private var searchFieldIsFocused: Bool
    
    var searchResults: [Boards] {
        
        var searchedBoards: [Boards] {
            if searchText.isEmpty {
                return boards
            } else {
                return boards.filter { item in
                    item.brand.localizedCaseInsensitiveContains(searchText) || item.model.localizedCaseInsensitiveContains(searchText) || item.material.localizedCaseInsensitiveContains(searchText) || item.finType.localizedCaseInsensitiveContains(searchText) || item.boardType.localizedCaseInsensitiveContains(searchText) || item.tailType.localizedCaseInsensitiveContains(searchText) ||
                        item.difficultyArray.joined(separator: ", ").localizedCaseInsensitiveContains(searchText) ||
                        item.waveRangeArray.joined(separator: ", ").localizedCaseInsensitiveContains(searchText) ||
                        item.powerRangeArray.joined(separator: ", ").localizedCaseInsensitiveContains(searchText)
                }
            }
        }
        
        var filteredBoards: [Boards] {
            if filters.filteredOptions.allSatisfy({$0 == "All"}) {
                return searchedBoards
            } else {
                return searchedBoards.filter { item in
                    filters.filteredOptions.contains { option in
                        item.brand.localizedCaseInsensitiveContains(option) || item.model.localizedCaseInsensitiveContains(option) || item.material.localizedCaseInsensitiveContains(option) || item.finType.localizedCaseInsensitiveContains(option) || item.boardType.localizedCaseInsensitiveContains(option) || item.tailType.localizedCaseInsensitiveContains(option) ||
                            item.difficultyArray.joined(separator: ", ").localizedCaseInsensitiveContains(option) ||
                        item.waveRangeArray.joined(separator: ", ").localizedCaseInsensitiveContains(option) ||
                        item.powerRangeArray.joined(separator: ", ").localizedCaseInsensitiveContains(option)
                    }
                }
            }
        }
        
        let finalBoards = isFavourited ? filteredBoards.filter{favourites.contains($0)} : filteredBoards
        
        return finalBoards.sorted {
            $0.model < $1.model
        }
        
    }
    
    var body: some View {
        
        NavigationView {
            ZStack {
                LinearGradient(colors: [Color(#colorLiteral(red: 0, green: 0.02060918883, blue: 0.02991674364, alpha: 1)), Color(#colorLiteral(red: 0, green: 0.08004814165, blue: 0.1161996114, alpha: 1))], startPoint: .top, endPoint: .bottom).ignoresSafeArea()
                
                if isFavourited && favourites.isEmpty() {
                    EmptyFavouritesView()
                } else if searchResults.isEmpty {
                    EmptySearchView()
                }
                
                ScrollView(showsIndicators: false) {
                        
                        LazyVGrid(columns: columns) {
                            
                            ForEach(searchResults) { board in
                                NavigationLink {
                                    BoardDetailView(board: board, favourites: favourites)
                                } label: {
                                    
                                    VStack(alignment: .leading, spacing: 14) {
                                        
                                         //Board brand, model and rating
                                        
                                        VStack(alignment: .leading) {
                                            HStack(alignment: .top) {
                                                HStack{
                                                    ZStack {
                                                        Image(board.image)
                                                            .resizable()
                                                            .scaledToFill()
                                                            .frame(width: 100, height: 100)
                                                            .clipShape(RoundedRectangle(cornerRadius: 8))
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
                        .background(GeometryReader { geometry in
                            Color.clear.preference(key: ScrollOffsetPreferenceKey.self, value: geometry.frame(in: .named("scroll")).origin)
                        })
                        .onPreferenceChange(ScrollOffsetPreferenceKey.self) { value in
                            self.scrollPosition = value
                        }
                        .padding(.top, CGFloat(topBarSize))
                        .padding([.horizontal, .bottom])
                        .padding(.bottom, 88)
                    }
                    .preferredColorScheme(.dark)
                    .navigationBarTitleDisplayMode(.inline)
                    .coordinateSpace(name: "scroll")
                    .onChange(of: scrollPosition.y) { value in
                        if value < CGFloat(topBarSize) - 32 {
                            hasScrolled = true
                        } else {
                            hasScrolled = false
                        }
                    }
                
                // Small bottom gradient behind toolbar
                VStack {
                    Spacer()
                    VStack {
                        LinearGradient(colors: [Color(#colorLiteral(red: 0, green: 0.08004814165, blue: 0.1161996114, alpha: 1)), Color(#colorLiteral(red: 0, green: 0.02060918883, blue: 0.02991674364, alpha: 0))], startPoint: .bottom, endPoint: .top)
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
                                ZStack {
                                    Image(systemName: "slider.horizontal.3")
                                        .foregroundColor(.white)
                                    if !filters.filteredOptions.allSatisfy({$0 == "All"}) {
                                        Circle()
                                            .fill(.blue)
                                            .frame(width: 16, height: 16)
                                            .shadow(color: .black.opacity(0.2), radius: 2, x: 0, y: 2)
                                            .offset(x: 16, y: -16)
                                    }
                                }
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
                .padding(.bottom, 32)
                
                VStack {
                    VStack {
                        if !hasScrolled {
                            HStack {
                                Image("boardlistLogo")
                                    .resizable()
                                    .scaledToFit()
                            }
                            .frame(width: 140)
                            .padding(.bottom, 12)
                        }
                        
                        
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
                                    .frame(height: 40)
                            }
                            .padding(.bottom, 16)
                            
                            if searchFieldIsFocused {
                                Button("Cancel") {
                                    searchFieldIsFocused = false
                                    searchText = ""
                                }
                                .padding(.horizontal, 6)
                                .padding(.vertical, 2)
                            }
                        }
                    }
                    .padding(.top, getSafeAreaTop())
                    .padding(.horizontal)
                    .padding(.bottom, 8)
                    .background(hasScrolled ? Color(#colorLiteral(red: 0, green: 0.03120037355, blue: 0.04797770083, alpha: 1)) : Color.clear)
                    .overlay(BottomBorder().stroke(hasScrolled ? Color.white.opacity(0.1) : Color.clear, lineWidth: 1.5))
                    .overlay {
                        GeometryReader { geometry in
                            Rectangle()
                                .stroke(Color.clear)
                                .onAppear{
                                    topBarSize = Int(geometry.size.height + 6)
                                }
                        }
                    }
                    
                    Spacer()
                }
                .animation(.easeInOut, value: hasScrolled)
            }
            .ignoresSafeArea()
        }
        .environmentObject(favourites)
        .sheet(isPresented: $isFiltersActive) {
            FilterSheetView(filters: filters)
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
    
    func getSafeAreaTop() -> CGFloat {
        let keyWindow = UIApplication.shared.connectedScenes
        
            .filter({$0.activationState == .foregroundActive})
            .map({$0 as? UIWindowScene})
            .compactMap({$0})
            .first?.windows
            .filter({$0.isKeyWindow}).first
        
        return keyWindow?.safeAreaInsets.top ?? 0
    }
    
}

struct BottomBorder: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        
        return path
    }
}

struct ScrollOffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGPoint = .zero
    static func reduce(value: inout CGPoint, nextValue: () -> CGPoint) {
        
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
        ContentView(filters: Filters())
    }
}
