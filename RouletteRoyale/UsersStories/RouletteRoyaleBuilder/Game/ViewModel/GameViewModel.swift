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
    
    init(userData: UserData) {
        self.userData = userData
    }
    
    func startGame() {
        isSpinning = true
        number = Int.random(in: 0...36)
        debugPrint(number)
    }
    
    func checkBet(betType: BetType, winningNumber: Int, betAmount: Int) {
        switch betType {
        case .none:
            break
        case .straight(let number):
            if number == winningNumber {
                let resultAmount = betAmount * 36
                userData.chips += resultAmount
                feedback = BetResult(win: true, amount: resultAmount)
            } else {
                userData.chips -= betAmount
                feedback = BetResult(win: false, amount: betAmount)
            }
            userData.saveToFirebase()
            
        case .column(let column):
            let numbersInColumns = [[3, 6, 9, 12, 15, 18, 21, 24, 27, 30, 33, 36],
                                    [2, 5, 8, 11, 14, 17, 20, 23, 26, 29, 32, 35],
                                    [1, 4, 7, 10, 13, 16, 19, 22, 25, 28, 31, 34]]
            
            switch column {
            case .first:
                if numbersInColumns[0].contains(winningNumber) {
                    let resultAmount = betAmount * 2
                    userData.chips += resultAmount
                    feedback = BetResult(win: true, amount: resultAmount)
                } else {
                    userData.chips -= betAmount
                    feedback = BetResult(win: false, amount: betAmount)
                }
                userData.saveToFirebase()
            case .second:
                if numbersInColumns[1].contains(winningNumber) {
                    let resultAmount = betAmount * 2
                    userData.chips += resultAmount
                    feedback = BetResult(win: true, amount: resultAmount)
                } else {
                    userData.chips -= betAmount
                    feedback = BetResult(win: false, amount: betAmount)
                }
                userData.saveToFirebase()
            case .third:
                if numbersInColumns[2].contains(winningNumber) {
                    let resultAmount = betAmount * 2
                    userData.chips += resultAmount
                    feedback = BetResult(win: true, amount: resultAmount)
                } else {
                    userData.chips -= betAmount
                    feedback = BetResult(win: false, amount: betAmount)
                }
                userData.saveToFirebase()
            }
        case .dozen(let dozen):
            let firstDozenNumbers = 1...12
            let secondDozenNumbers = 13...24
            let thirdDozenNumbers = 25...36
            let winningDozen: ClosedRange<Int>
            
            switch dozen {
                
            case .first:
                winningDozen = firstDozenNumbers
            case .second:
                winningDozen = secondDozenNumbers
            case .third:
                winningDozen = thirdDozenNumbers
            }
            
            if winningDozen.contains(winningNumber) {
                let resultAmount = betAmount * 3
                userData.chips += resultAmount
                feedback = BetResult(win: true, amount: resultAmount)
            } else {
                userData.chips -= betAmount
                feedback = BetResult(win: false, amount: betAmount)
            }
            userData.saveToFirebase()
            
        case .lowHigh(let high):
            
            let winningRange: ClosedRange<Int> = high ? 19...36 : 1...18
            if winningRange.contains(winningNumber) {
                let resultAmount = betAmount * 2
                userData.chips += resultAmount
                feedback = BetResult(win: true, amount: resultAmount)
            } else {
                userData.chips -= betAmount
                feedback = BetResult(win: false, amount: betAmount)
            }
            userData.saveToFirebase()
            
        case .redBlack(let color):
            
            let winningColor: BetType.ColorType = winningNumber % 2 == 0 ? .black : .red
            if color == winningColor {
                let resultAmount = betAmount * 2
                userData.chips += resultAmount
                feedback = BetResult(win: true, amount: resultAmount)
            } else {
                userData.chips -= betAmount
                feedback = BetResult(win: false, amount: betAmount)
            }
            userData.saveToFirebase()
            
        case .oddEven(let odd):
            let winningParity = winningNumber % 2 == 0 ? false : true
            if odd == winningParity {
                let resultAmount = betAmount * 2
                userData.chips += resultAmount
                feedback = BetResult(win: true, amount: resultAmount)
            } else {
                userData.chips -= betAmount
                feedback = BetResult(win: false, amount: betAmount)
            }
            userData.saveToFirebase()
        }
        isSpinning = false
    }
}
