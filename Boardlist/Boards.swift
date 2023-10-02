//
//  Boards.swift
//  Boardlist
//
//  Created by Renato Martins on 30/08/2023.
//

import Foundation
import SwiftUI

struct Boards: Codable, Identifiable{
    
    let id: Int
    let brand: String
    let model: String
    let image: String
    let photos: [String]
    let description: String
    let size: [String]
    let material: String
    let finSystem: String
    let finType: String
    let boardType: String
    let tailType: String
    let difficulty: [Int]
    let waveRange: [Int]
    let powerRange: [Int]
    let userReview: [UserReview]
    
    var ratingTotal: Int {
        let total = userReview.reduce(0) { $0 + $1.rating }
        return total / userReview.count
    }
    
    struct UserReview: Codable, Identifiable {
        let id: Int
        let rating: Int
        let location: String
        let description: String
    }
}
