//
//  TableViewModel.swift
//  RouletteRoyale
//
//  Created by Dmytro Grytsenko on 27.08.2023.
//

import Foundation

final class TableViewModel: ObservableObject {
    var betType: BetType
    @Published private var selectedBet: BetType = .none
    
    init(betType: BetType) {
        self.betType = betType
    }
    
    private func makeBet(bet: BetType) {
        selectedBet = (selectedBet == bet) ? .none : bet
    }
    
    private func checkSelectedCell(bet: BetType) -> Bool {
        selectedBet == bet ? true : false
    }
    
    private func addBet(bet: BetType) {
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
