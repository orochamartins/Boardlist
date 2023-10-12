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
    
    var difficultyArray: [String] {
        switch difficulty {
        case [1, 2]:
            return ["Beginner", "Intermediate"]
        case [1, 3]:
            return ["Beginner", "Intermediate", "Advanced"]
        case [1, 4]:
            return ["Beginner", "Intermediate", "Advanced", "Professional"]
        case [2, 3]:
            return ["Intermediate", "Advanced"]
        case [2, 4]:
            return ["Intermediate", "Advanced", "Professional"]
        case [3, 4]:
            return ["Advanced", "Professional"]
        default:
            return ["Not disclosed"]
        }
    }
    
    var waveRangeArray: [String] {
        switch waveRange {
        case [1, 2]:
            return ["Knee", "Head height"]
        case [1, 3]:
            return ["Knee", "Head height", "Overhead"]
        case [1, 4]:
            return ["Knee", "Head height", "Overhead", "Double+"]
        case [2, 3]:
            return ["Head height", "Overhead"]
        case [2, 4]:
            return ["Head height", "Overhead", "Double+"]
        case [3, 4]:
            return ["Overhead", "Double+"]
        default:
            return ["Not disclosed"]
        }
    }
    
    var powerRangeArray: [String] {
        switch powerRange {
        case [1, 2]:
            return ["Weak", "Medium"]
        case [1, 3]:
            return ["Weak", "Medium", "Strong"]
        case [1, 4]:
            return ["Weak", "Medium", "Strong", "Barrels"]
        case [2, 3]:
            return ["Medium", "Strong"]
        case [2, 4]:
            return ["Medium", "Strong", "Barrels"]
        case [3, 4]:
            return ["Strong", "Barrels"]
        default:
            return ["Not disclosed"]
        }
    }
    
    struct UserReview: Codable, Identifiable {
        let id: Int
        let rating: Int
        let location: String
        let description: String
    }
}
