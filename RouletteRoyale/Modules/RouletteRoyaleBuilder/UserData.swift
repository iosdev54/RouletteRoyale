//
//  UserData.swift
//  RouletteRoyale
//
//  Created by Dmytro Grytsenko on 17.08.2023.
//

import Foundation

struct UserData {
    let name: String
    let chips: Int
    let winRate: Double
    
    init?(snapshot: [String: Any]) {
        guard let name = snapshot["name"] as? String,
              let chips = snapshot["chips"] as? Int,
              let winRate = snapshot["winRate"] as? Double else {
            return nil
        }
        
        self.name = name
        self.chips = chips
        self.winRate = winRate
    }
}
