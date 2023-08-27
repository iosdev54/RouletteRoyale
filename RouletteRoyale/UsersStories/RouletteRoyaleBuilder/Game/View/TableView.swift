//
//  TableView.swift
//  RouletteRoyale
//
//  Created by Dmytro Grytsenko on 18.08.2023.
//

import SwiftUI

struct TableView: View {
    @Binding var betType: BetType
    @State private var selectedBet: BetType = .none
    
    let width: CGFloat
    let height: CGFloat
    
    private let topRowCellWidth: CGFloat
    private let topRowCellHeight: CGFloat
    private let bottomRowCellHeight: CGFloat
    private var adjustment: CGFloat
    
    init(betType: Binding<BetType>, width: CGFloat, height: CGFloat) {
        self._betType = betType
        self.width = width
        self.height = height
        
        self.topRowCellWidth = width / 14
        self.topRowCellHeight = height * 0.2
        self.bottomRowCellHeight = height * 0.14
        self.adjustment = height - ((topRowCellHeight * 3) + (bottomRowCellHeight * 2))
    }
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                TextView(tableType: .zero(number: 0), width: topRowCellWidth, height: topRowCellHeight * 3, selection: checkSelectedCell(bet: .straight(number: 0)))
                    .onTapGesture {
                        makeBet(bet: .straight(number: 0))
                    }
                
                VStack(spacing: 0) {
                    ForEach((0...2), id: \.self) { i in
                        HStack(spacing: 0) {
                            ForEach((1...12), id: \.self) { j in
                                let number = j * 3 - i
                                TextView(tableType: .straight(number: number), width: topRowCellWidth, height: topRowCellHeight, selection: checkSelectedCell(bet: .straight(number: number)))
                                    .onTapGesture {
                                        makeBet(bet: .straight(number: number))
                                    }
                            }
                        }
                    }
                }
                
                VStack(spacing: 0) {
                    ForEach((0...2), id: \.self) { column in
                        
                        if let columnType = BetType.ColumnType(rawValue: column) {
                            TextView(tableType: .column(text: "2 to 1"), width: topRowCellWidth, height: topRowCellHeight, selection: checkSelectedCell(bet: .column(column: columnType)))
                                .onTapGesture {
                                    makeBet(bet: .column(column: columnType))
                                }
                        }
                    }
                }
            }
            
            HStack(spacing: 0) {
                ForEach((0...2), id: \.self) { i in
                    let text = ["st","nd","rd"]
                    
                    if let dozenType = BetType.DozenType(rawValue: i) {
                        TextView(tableType: .dozen(text: "\(i + 1)\(text[i]) 12"), width: topRowCellWidth * 4, height: bottomRowCellHeight, selection: checkSelectedCell(bet: .dozen(dozen: dozenType)))
                            .onTapGesture {
                                makeBet(bet: .dozen(dozen: dozenType))
                            }
                    }
                }
            }
            
            HStack(spacing: 0) {
                TextView(tableType: .lowHigh(text: "1 to 18"), width: topRowCellWidth * 2, height: bottomRowCellHeight, selection: checkSelectedCell(bet: .lowHigh(high: false)))
                    .onTapGesture {
                        makeBet(bet: .lowHigh(high: false))
                    }
                
                TextView(tableType: .oddEven(text: "Even"), width: topRowCellWidth * 2, height: bottomRowCellHeight, selection: checkSelectedCell(bet: .oddEven(odd: false)))
                    .onTapGesture {
                        makeBet(bet: .oddEven(odd: false))
                    }
                
                TextView(tableType: .redBlack(color: .red), width: topRowCellWidth * 2, height: bottomRowCellHeight, selection: checkSelectedCell(bet: .redBlack(color: .red)))
                    .onTapGesture {
                        makeBet(bet: .redBlack(color: .red))
                    }
                
                TextView(tableType: .redBlack(color: .black), width: topRowCellWidth * 2, height: bottomRowCellHeight, selection: checkSelectedCell(bet: .redBlack(color: .black)))
                    .onTapGesture {
                        makeBet(bet: .redBlack(color: .black))
                    }
                
                TextView(tableType: .oddEven(text: "Odd"), width: topRowCellWidth * 2, height: bottomRowCellHeight, selection: checkSelectedCell(bet: .oddEven(odd: true)))
                    .onTapGesture {
                        makeBet(bet: .oddEven(odd: true))
                    }
                
                TextView(tableType: .lowHigh(text: "19 to 36"), width: topRowCellWidth * 2, height: bottomRowCellHeight, selection: checkSelectedCell(bet: .lowHigh(high: true)))
                    .onTapGesture {
                        makeBet(bet: .lowHigh(high: true))
                    }
            }
        }
        .frame(width: width, height: height - adjustment)
        .onChange(of: selectedBet) { bet in
            addBet(bet: bet)
        }
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

struct TableView_Previews: PreviewProvider {
    
    static var previews: some View {
        ZStack {
            Constants.Images.gameBackground
                .resizable()
                .ignoresSafeArea()
            
            TableView(betType: .constant(.none), width: 350, height: 250)
        }
    }
}
