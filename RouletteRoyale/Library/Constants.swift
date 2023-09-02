//
//  Constants.swift
//  RouletteRoyale
//
//  Created by Dmytro Grytsenko on 27.08.2023.
//

import SwiftUI

enum Constants {
    static let tabBarBackgroundColor = UIColor(red: 0.48, green: 0.59, blue: 0.41, alpha: 1.00)
    
    static let tabBarItemTintColor = Color(red: 0.98, green: 0.77, blue: 0.19)
    static let tabBarUnselectedItemTintColor = UIColor(red: 0.98, green: 0.77, blue: 0.19, alpha: 1.00).withAlphaComponent(0.4)
    
    enum Images {
        static let gameBackground = Image("gameBackground")
        static let rouletteImage = Image("roulette")
        static let dollarImage = Image("dollar")
    }
}
