//
//  GameViewModel.swift
//  RouletteRoyale
//
//  Created by Dmytro Grytsenko on 18.08.2023.
//

import Foundation

final class GameViewModel: ObservableObject {
    @Published var userData: UserData
    @Published var betType: BetType = .none
    @Published var number: Int = 34
    @Published var bet = 10
    
    @Published var feedback: BetResult?
    @Published var isSpinning = false
    
    var betAmount: Int {
        userData.chips / bet
    }
    
    private var isBetPlaced: Bool {
        return betType != .none
    }
    
    var canStartGame: Bool {
        return isBetPlaced && !isSpinning
    }
    
    init(userData: UserData) {
        self.userData = userData
    }
    
    func startGame() {
        isSpinning = true
        number = Int.random(in: 0...36)
        debugPrint(number)
    }
    
    func checkBet(betType: BetType, winningNumber: Int, betAmount: Int) {
        var resultAmount = 0
        var win = false
        
        switch betType {
        case .none:
            break
        case .straight(let number):
            win = number == winningNumber
            resultAmount = win ? betAmount * 36 : -betAmount
        case .column(let column):
            let winningColumns = GameConstants.numbersInColumns[column.rawValue]
            win = winningColumns.contains(winningNumber)
            resultAmount = win ? betAmount * 2 : -betAmount
        case .dozen(let dozen):
            let winningRange = GameConstants.dozenNumbers[dozen.rawValue]
            win = winningRange.contains(winningNumber)
            resultAmount = win ? betAmount * 3 : -betAmount
        case .lowHigh(let high):
            let winningRange = high ? 19...36 : 1...18
            win = winningRange.contains(winningNumber)
            resultAmount = win ? betAmount * 2 : -betAmount
        case .redBlack(let color):
            let winningColor: BetType.ColorType = GameConstants.blackBlock.contains(winningNumber) ? .black : .red
            win = color == winningColor
            resultAmount = win ? betAmount * 2 : -betAmount
        case .oddEven(let odd):
            let winningParity = winningNumber % 2 == 0 ? false : true
            win = odd == winningParity
            resultAmount = win ? betAmount * 2 : -betAmount
        }
        
        userData.chips += resultAmount
        feedback = BetResult(win: win, amount: abs(resultAmount))
        userData.saveToFirebase()
        isSpinning = false
    }
}
