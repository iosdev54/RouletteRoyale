//
//  GameConstants.swift
//  RouletteRoyale
//
//  Created by Dmytro Grytsenko on 27.08.2023.
//

import Foundation

enum GameConstants {
    static let numbers = [34, 17, 25, 2, 21, 4, 19, 15, 32, 0, 26, 3, 35, 12, 28, 7, 29, 18, 22, 9, 31, 14, 20, 1, 33, 16, 24 ,5, 10, 23, 8, 30, 11, 36, 13, 27, 6]
    
    static let numbersInColumns = [[3, 6, 9, 12, 15, 18, 21, 24, 27, 30, 33, 36],
                                   [2, 5, 8, 11, 14, 17, 20, 23, 26, 29, 32, 35],
                                   [1, 4, 7, 10, 13, 16, 19, 22, 25, 28, 31, 34]]
    
    static let dozenNumbers = [1...12, 13...24, 25...36]
    
    
    static let redBlock = [1,3,5,7,9,12,14,16,18,19,21,23,25,27,30,32,34,36]
    static let blackBlock = [2,4,6,8,10,11,13,15,17,20,22,24,26,28,29,31,33,35]
    
}
