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
    
    private let rowCellWidth: CGFloat
    private let rowCellHeight: CGFloat
    
    private let redBlock = [1,3,5,7,9,12,14,16,18,19,21,23,25,27,30,32,34,36]
    
    init(betType: Binding<BetType>, width: CGFloat, height: CGFloat) {
        self._betType = betType
        self.width = width
        self.height = height
        
        self.rowCellWidth = width / 14
        self.rowCellHeight = height / 5
    }
    
    private func placeBet(bet: BetType) {
        selectedBet = (selectedBet == bet) ? .none : bet
    }
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    TextView(tableType: .type1, text: "0", width: rowCellWidth, height: rowCellHeight * 3)
                        .background((selectedBet == .straight(number: 0) ? .yellow : .green))
                        .onTapGesture {
                            placeBet(bet: .straight(number: 0))
                        }
                    
                    
                    VStack(spacing: 0) {
                        ForEach((0...2), id: \.self) { i in
                            HStack(spacing: 0) {
                                ForEach((1...12), id: \.self) { j in
                                    let number = j * 3 - i
                                    TextView(tableType: .type2, text: "\(number)", width: rowCellWidth, height: rowCellHeight)
                                        .background(selectedBet == .straight(number: number) ? .yellow : redBlock.contains(number) ? .red : .black)
                                        .onTapGesture {
                                            placeBet(bet: .straight(number: number))
                                        }
                                }
                            }
                        }
                    }
                    
                    VStack(spacing: 0) {
                        ForEach((0...2), id: \.self) { column in
                            
                            if let columnType = BetType.ColumnType(rawValue: column) {
                                TextView(tableType: .type3, text: "2 to 1", width: rowCellWidth, height: rowCellHeight)
                                    .background(selectedBet == .column(column: columnType) ? .yellow : .clear)
                                    .onTapGesture {
                                        placeBet(bet: .column(column: columnType))
                                    }
                            }
                        }
                    }
                }
                
                HStack(spacing: 0) {
                    ForEach((0...2), id: \.self) { i in
                        let text = ["st","nd","rd"]
                        
                        if let dozenType = BetType.DozenType(rawValue: i) {
                            TextView(tableType: .type4, text: "\(i + 1)\(text[i]) 12", width: rowCellWidth * 4, height: rowCellHeight)
                                .background(selectedBet == .dozen(dozen: dozenType) ? .yellow : .clear)
                                .onTapGesture {
                                    placeBet(bet: .dozen(dozen: dozenType))
                                }
                        }
                    }
                }
                
                HStack(spacing: 0) {
                    TextView(tableType: .type5, text: "1 to 18", width: rowCellWidth * 2, height: rowCellHeight)
                        .background(selectedBet == .lowHigh(high: false) ? .yellow : .clear)
                        .onTapGesture {
                            placeBet(bet: .lowHigh(high: false))
                        }
                    
                    TextView(tableType: .type5, text: "Even", width: rowCellWidth * 2, height: rowCellHeight)
                        .background(selectedBet == .oddEven(odd: false) ? .yellow : .clear)
                        .onTapGesture {
                            placeBet(bet: .oddEven(odd: false))
                        }
                    
                    
                    TextView(tableType: .type5, text: "Red", width: rowCellWidth * 2, height: rowCellHeight)
                        .background(selectedBet == .redBlack(color: .red) ? .yellow : .red)
                        .onTapGesture {
                            placeBet(bet: .redBlack(color: .red))
                        }
                    
                    TextView(tableType: .type5, text: "Black", width: rowCellWidth * 2, height: rowCellHeight)
                        .background(selectedBet == .redBlack(color: .black) ? .yellow : .black)
                        .onTapGesture {
                            placeBet(bet: .redBlack(color: .black))
                        }
                    
                    TextView(tableType: .type5, text: "Odd", width: rowCellWidth * 2, height: rowCellHeight)
                        .background(selectedBet == .oddEven(odd: true) ? .yellow : .clear)
                        .onTapGesture {
                            placeBet(bet: .oddEven(odd: true))
                        }
                    
                    TextView(tableType: .type5, text: "19 to 36", width: rowCellWidth * 2, height: rowCellHeight)
                        .background(selectedBet == .lowHigh(high: true) ? .yellow : .clear)
                        .onTapGesture {
                            placeBet(bet: .lowHigh(high: true))
                        }
                }
            }
        }
        .frame(width: width, height: height)
        .onChange(of: selectedBet) { bet in
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
}

struct TableView_Previews: PreviewProvider {
    
    static var previews: some View {
        TableView(betType: .constant(.none), width: .infinity, height: 250)
            .previewDevice(PreviewDevice(rawValue: "iPad (10nd generation)"))
            .background(.green)
    }
}
