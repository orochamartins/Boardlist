//
//  BoardDetailView.swift
//  Boardlist
//
//  Created by Renato Martins on 24/09/2023.
//

import SwiftUI

struct BoardDetailView: View {
    
    let board: Boards
    @ObservedObject var favourites: Favourites
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [Color(#colorLiteral(red: 0, green: 0.02060918883, blue: 0.02991674364, alpha: 1)), Color(#colorLiteral(red: 0, green: 0.08004814165, blue: 0.1161996114, alpha: 1))], startPoint: .top, endPoint: .bottom).ignoresSafeArea()
            
            VStack {
                ImageScrollView(board: board)
                
                VStack(alignment: .leading, spacing: 14) {
                    VStack(alignment: .leading) {
                        HStack(alignment: .top) {
                            HStack{
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
                    }
                    .frame(maxWidth: .infinity)
                    .padding([.horizontal, .bottom])
                }
                .background(.thinMaterial.opacity(0.6))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(.ultraThinMaterial))
                .padding(.bottom, 8)
                
                Text("Description:")
                    .font(.footnote)
                    .opacity(0.5)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding([.horizontal, .top])
                
                VStack(alignment: .leading, spacing: 14) {
                    VStack(alignment: .leading) {
                        Text(board.description)
                            .foregroundColor(.white.opacity(0.5))
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                }
                .background(.thinMaterial.opacity(0.6))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(.ultraThinMaterial))
                .padding(.bottom, 8)
                
                Text("Attributes:")
                    .font(.footnote)
                    .opacity(0.5)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding([.horizontal, .top])
                
                VStack(alignment: .leading, spacing: 14) {
                    VStack(alignment: .leading) {
                        HStack(alignment: .center) {
                            GaugeView(value: board.difficulty)
                            WaveGaugeView(value: board.waveRange)
                            PowerGaugeView(value: board.powerRange)
                        }
                        .frame(maxWidth: .infinity)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                }
                .background(.thinMaterial.opacity(0.6))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(.ultraThinMaterial))
                .padding(.bottom, 8)
                
            }
        }
        .navigationTitle(board.model)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct BoardDetailView_Previews: PreviewProvider {
    static var previews: some View {
        
        let boards: [Boards] = Bundle.main.decode("boards.json")
        
        BoardDetailView(board: boards[0], favourites: Favourites())
            .preferredColorScheme(.dark)
    }
}
