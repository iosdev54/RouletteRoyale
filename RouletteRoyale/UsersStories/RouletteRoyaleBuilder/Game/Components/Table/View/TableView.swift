//
//  TableView.swift
//  RouletteRoyale
//
//  Created by Dmytro Grytsenko on 18.08.2023.
//

import SwiftUI

struct TableView: View {
    @StateObject private var viewModel: TableViewModel
    
    init(betType: Binding<BetType>, width: CGFloat, height: CGFloat) {
        self._viewModel = StateObject(wrappedValue: TableViewModel(betType: betType, width: width, height: height))
    }
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                TextView(tableType: .zero(number: 0), width: viewModel.topRowCellWidth, height: viewModel.topRowCellHeight * 3, isSelected: viewModel.checkSelectedBet(.straight(number: 0))) {
                    viewModel.selectBet(.straight(number: 0))
                }
                
                VStack(spacing: 0) {
                    ForEach((0...2), id: \.self) { i in
                        HStack(spacing: 0) {
                            ForEach((1...12), id: \.self) { j in
                                let number = j * 3 - i
                                TextView(tableType: .straight(number: number), width: viewModel.topRowCellWidth, height: viewModel.topRowCellHeight, isSelected: viewModel.checkSelectedBet(.straight(number: number))) {
                                    viewModel.selectBet(.straight(number: number))
                                }
                            }
                        }
                    }
                }
                
                VStack(spacing: 0) {
                    ForEach((0...2), id: \.self) { column in
                        
                        if let columnType = BetType.ColumnType(rawValue: column) {
                            TextView(tableType: .column(text: "2 to 1"), width: viewModel.topRowCellWidth, height: viewModel.topRowCellHeight, isSelected: viewModel.checkSelectedBet(.column(column: columnType))) {
                                viewModel.selectBet(.column(column: columnType))
                            }
                        }
                    }
                }
            }
            
            HStack(spacing: 0) {
                ForEach((0...2), id: \.self) { i in
                    let text = ["st","nd","rd"]
                    
                    if let dozenType = BetType.DozenType(rawValue: i) {
                        TextView(tableType: .dozen(text: "\(i + 1)\(text[i]) 12"), width: viewModel.topRowCellWidth * 4, height: viewModel.bottomRowCellHeight, isSelected: viewModel.checkSelectedBet(.dozen(dozen: dozenType))) {
                            viewModel.selectBet(.dozen(dozen: dozenType))
                        }
                    }
                }
            }
            
            HStack(spacing: 0) {
                TextView(tableType: .lowHigh(text: "1 to 18"), width: viewModel.topRowCellWidth * 2, height: viewModel.bottomRowCellHeight, isSelected: viewModel.checkSelectedBet(.lowHigh(high: false))) {
                    viewModel.selectBet(.lowHigh(high: false))
                }
                
                TextView(tableType: .oddEven(text: "Even"), width: viewModel.topRowCellWidth * 2, height: viewModel.bottomRowCellHeight, isSelected: viewModel.checkSelectedBet(.oddEven(odd: false))) {
                    viewModel.selectBet(.oddEven(odd: false))
                }
                
                TextView(tableType: .redBlack(color: .red), width: viewModel.topRowCellWidth * 2, height: viewModel.bottomRowCellHeight, isSelected: viewModel.checkSelectedBet(.redBlack(color: .red))) {
                    viewModel.selectBet(.redBlack(color: .red))
                }
                
                TextView(tableType: .redBlack(color: .black), width: viewModel.topRowCellWidth * 2, height: viewModel.bottomRowCellHeight, isSelected: viewModel.checkSelectedBet(.redBlack(color: .black))) {
                    viewModel.selectBet(.redBlack(color: .black))
                }
                
                TextView(tableType: .oddEven(text: "Odd"), width: viewModel.topRowCellWidth * 2, height: viewModel.bottomRowCellHeight, isSelected: viewModel.checkSelectedBet(.oddEven(odd: true))) {
                    viewModel.selectBet(.oddEven(odd: true))
                }
                
                TextView(tableType: .lowHigh(text: "19 to 36"), width: viewModel.topRowCellWidth * 2, height: viewModel.bottomRowCellHeight, isSelected: viewModel.checkSelectedBet(.lowHigh(high: true))) {
                    viewModel.selectBet(.lowHigh(high: true))
                }
            }
        }
        .frame(width: viewModel.width, height: viewModel.height - viewModel.adjustment)
        .onChange(of: viewModel.selectedBet) { bet in
            viewModel.addBet(bet: bet)
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
