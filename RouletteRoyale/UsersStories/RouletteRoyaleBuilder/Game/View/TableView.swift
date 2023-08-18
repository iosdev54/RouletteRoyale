//
//  TableView.swift
//  RouletteRoyale
//
//  Created by Dmytro Grytsenko on 18.08.2023.
//

import SwiftUI

struct TableView: View {
    private let TwoToOne = [[3,6,9,12,15,18,21,24,27,30,33,36],
                            [2,5,8,11,14,17,20,23,26,29,32,35],
                            [1,4,7,10,13,16,19,22,25,28,31,34]]
    private let StNdRd = [[ 1, 2, 3, 4, 5, 6, 7, 8, 9,10,11,12],
                          [13,14,15,16,17,18,19,20,21,22,23,24],
                          [25,26,27,28,29,30,31,32,33,34,35,36]]
    private let ThirtySix = [[ 1, 2, 3, 4, 5, 6, 7, 8, 9,10,11,12,13,14,15,16,17,18],
                             [19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36]]
    private let Even = [1,3,5,7,9,11,13,15,17,19,21,23,25,27,29,31,33,35]
    private let Odd = [2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36]
    private let redBlock = [1,3,5,7,9,12,14,16,18,19,21,23,25,27,30,32,34,36]
    private let blackBlock = [2,4,6,8,10,11,13,15,17,20,22,24,26,28,29,31,33,35]
    
    @Binding var num : Int
    @State var selectedField = ""
    
    let width: CGFloat
    let height: CGFloat
    
    private let rowCellWidth: CGFloat
    private let rowCellHeight: CGFloat
    
    init(num: Binding<Int>, width: CGFloat, height: CGFloat) {
        self._num = num
        self.width = width
        self.height = height
        
        self.rowCellWidth = width / 14
        self.rowCellHeight = height / 5
    }
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    TextView(mode: 1, text: "0", width: rowCellWidth, height: height * 0.6)
                        .background(num == 0 ? .yellow : .green)
                        .onTapGesture {
                            
                        }
                    
                    VStack(spacing: 0) {
                        ForEach((0...2), id: \.self) { i in
                            HStack(spacing: 0) {
                                ForEach((1...12), id: \.self) { j in
                                    TextView(mode: 2, text: "\(j * 3 - i)", width: rowCellWidth, height: rowCellHeight)
                                    
                                        .background(num == j * 3 - i ? .yellow : redBlock.contains(j * 3 - i) ? .red : .black)
                                }
                            }
                        }
                    }
                    
                    VStack(spacing: 0) {
                        ForEach((0...2), id: \.self) { i in
                            TextView(mode: 3, text: "2to1", width: rowCellWidth, height: rowCellHeight)
                        }
                    }
                }
                
                HStack(spacing: 0) {
                    ForEach((0...2), id: \.self) { i in
                        let s = ["st","nd","rd"]
                        TextView(mode: 4, text: "\(i + 1)\(s[i]) 12", width: rowCellWidth * 4, height: rowCellHeight)
                    }
                }
                
                HStack(spacing: 0) {
                    TextView(mode: 5, text: "1 - 18", width: rowCellWidth * 2, height: rowCellHeight)
                    
                    TextView(mode: 5, text: "Even", width: rowCellWidth * 2, height: rowCellHeight)
                    
                    TextView(mode: 5, text: "Red", width: rowCellWidth * 2, height: rowCellHeight)
                        .background(.red)
                    
                    TextView(mode: 5, text: "Black", width: rowCellWidth * 2, height: rowCellHeight)
                        .background(.black)
                    
                    TextView(mode: 5, text: "Odd", width: rowCellWidth * 2, height: rowCellHeight)
                    
                    TextView(mode: 5, text: "19 - 36", width: rowCellWidth * 2, height: rowCellHeight)
                }
            }
        }
        .frame(width: width, height: height)
    }
}

struct TableView_Previews: PreviewProvider {
    
    static var previews: some View {
        TableView(num: .constant(-1), width: 400, height: 210)
            .previewDevice(PreviewDevice(rawValue: "iPad (10nd generation)"))
            .background(.gray)
    }
}
