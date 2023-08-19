//
//  TextView.swift
//  RouletteRoyale
//
//  Created by Dmytro Grytsenko on 18.08.2023.
//

import SwiftUI

struct TextView: View {
    enum TableType {
        case type1, type2, type3, type4, type5
    }
    
    @State var tableType: TableType
    @State var text: String
    
    let width: CGFloat
    let height: CGFloat
    
    var body: some View {
        if tableType == .type1 || tableType == .type2 || tableType == .type3 {
            Text(text)
                .rotationEffect(.degrees(270), anchor: .center)
                .font(tableType == .type3 ? .footnote : .body)
                .kerning(tableType == .type3 ? -1 : 0)
                .minimumScaleFactor(tableType == .type3 ? 0.7 : 1)
                .lineLimit(1)
                .foregroundColor(.white)
                .frame(width: width, height: height)
                .border(.white, width: 1)
            //                .contentShape(Rectangle())
            
        } else if tableType == .type4 || tableType == .type5 {
            Text(text)
                .foregroundColor(.white)
                .font(.body)
                .kerning(tableType == .type5 ? -1 : 0)
                .minimumScaleFactor(tableType == .type5 ? 0.7 : 1)
                .lineLimit(1)
                .frame(width: width, height: height)
                .border(.white, width: 1)
            //                .contentShape(Rectangle())
        }
    }
}
