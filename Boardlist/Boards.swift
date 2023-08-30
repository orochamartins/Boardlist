//
//  Boards.swift
//  Boardlist
//
//  Created by Renato Martins on 30/08/2023.
//

import Foundation

struct Boards: Codable, Identifiable {
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
    let tailType: String
    let difficulty: [Int]
    let waveRange: [Int]
    let userReview: [UserReview]
    
    struct UserReview: Codable {
        let rating: Int
        let location: String
        let description: String
    }
    
}
