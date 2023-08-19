//
//  BetType.swift
//  RouletteRoyale
//
//  Created by Dmytro Grytsenko on 19.08.2023.
//

import Foundation

enum BetType: Equatable {
    enum ColumnType: Int {
        case first, second, third
    }
    
    enum DozenType: Int {
        case first, second, third
    }
    
    enum ColorType {
        case red, black
    }
    
    case none
    case straight(number: Int)
    case column(column: BetType.ColumnType)
    case dozen(dozen: BetType.DozenType)
    case lowHigh(high: Bool)
    case redBlack(color: BetType.ColorType)
    case oddEven(odd: Bool)
}
