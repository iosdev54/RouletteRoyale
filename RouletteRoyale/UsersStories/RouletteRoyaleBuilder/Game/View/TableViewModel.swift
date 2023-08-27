//
//  TableViewModel.swift
//  RouletteRoyale
//
//  Created by Dmytro Grytsenko on 27.08.2023.
//

import SwiftUI

final class TableViewModel: ObservableObject {
    @Binding var betType: BetType
    @Published private(set) var selectedBet: BetType = .none
    
    let width: CGFloat
    let height: CGFloat
    
    let topRowCellWidth: CGFloat
    let topRowCellHeight: CGFloat
    let bottomRowCellHeight: CGFloat
    var adjustment: CGFloat
    
    init(betType: Binding<BetType>, width: CGFloat, height: CGFloat) {
        self._betType = betType
        self.width = width
        self.height = height
        
        self.topRowCellWidth = width / 14
        self.topRowCellHeight = height * 0.2
        self.bottomRowCellHeight = height * 0.14
        self.adjustment = height - ((topRowCellHeight * 3) + (bottomRowCellHeight * 2))
    }
    
    func makeBet(_ bet: BetType) {
        selectedBet = (selectedBet == bet) ? .none : bet
    }
    
    func checkSelectedCell(_ bet: BetType) -> Bool {
        selectedBet == bet ? true : false
    }
    
    func addBet(bet: BetType) {
        switch bet {
        case .none:
            betType = .none
        case .straight(let number):
            betType = .straight(number: number)
        case .column(let column):
            betType = .column(column: column)
        case .dozen(let dozen):
            betType = .dozen(dozen: dozen)
        case .lowHigh(let high):
            betType = .lowHigh(high: high)
        case .redBlack(let color):
            betType = .redBlack(color: color)
        case .oddEven(let odd):
            betType = .oddEven(odd: odd)
        }
    }
}
