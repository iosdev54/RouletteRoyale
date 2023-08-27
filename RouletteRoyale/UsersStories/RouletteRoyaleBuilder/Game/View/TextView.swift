//
//  TextView.swift
//  RouletteRoyale
//
//  Created by Dmytro Grytsenko on 18.08.2023.
//

import SwiftUI

struct TextView: View {
    enum TableType: Equatable {
        case zero(number: Int)
        case straight(number: Int)
        case column(text: String)
        case dozen(text: String)
        case lowHigh(text: String)
        case redBlack(color: BetType.ColorType)
        case oddEven(text: String)
    }
    
    private struct ZeroShape: Shape {
        func path(in rect: CGRect) -> Path {
            var path = Path()
            path.move(to: CGPoint(x: rect.maxX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.midY))
            path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
            path.closeSubpath()
            return path
        }
    }
    
    private struct ColorShape: Shape {
        func path(in rect: CGRect) -> Path {
            var path = Path()
            path.move(to: CGPoint(x: rect.midX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
            path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.midY))
            path.closeSubpath()
            return path
        }
    }
    
    let tableType: TableType
    let width: CGFloat
    let height: CGFloat
    let selection: Bool
    
    var body: some View {
        switch tableType {
        case .zero(number: let number):
            ZStack {
                ZeroShape()
                    .fill(selection ? .yellow.opacity(0.8) : .clear)
                
                getText(with: tableType, text: "\(number)")
            }
            
        case .straight(number: let number):
            ZStack {
                Ellipse()
                    .fill(GameConstants.redBlock.contains(number) ? .red : .black)
                    .frame(width: width * 0.8, height: height * 0.75)
                
                getText(with: tableType, text: "\(number)")
            }
            .background(selection ? .yellow.opacity(0.8) : .clear)
            
        case .column(text: let text), .dozen(text: let text), .lowHigh(text: let text), .oddEven(text: let text):
            getText(with: tableType, text: text)
                .background(selection ? .yellow.opacity(0.8) : .clear)
            
        case .redBlack(let color):
            ZStack {
                ColorShape()
                    .fill(color == .red ? .red : .black)
                    .frame(width: width * 0.6, height: height * 0.6)
                
                getText(with: tableType, text: "")
            }
            .background(selection ? .yellow.opacity(0.8) : .clear)
        }
    }
    
    private func getText(with type: TableType, text: String) -> some View {
        var kerning: CGFloat {
            switch type {
            case .column, .lowHigh: return -1
            default: return 0
            }
        }
        
        var minimumScaleFactor: CGFloat {
            switch type {
            case .column, .lowHigh: return 0.7
            default: return 1
            }
        }
        
        return Text(text)
            .rotationEffect(rotationAngle(for: type), anchor: .center)
            .kerning(kerning)
            .minimumScaleFactor(minimumScaleFactor)
            .lineLimit(1)
            .foregroundColor(.white)
            .frame(width: width, height: height)
            .overlay(overlayShape(with: type))
    }
    
    private func rotationAngle(for type: TableType) -> Angle {
        switch type {
        case .zero, .straight, .column:
            return .degrees(270)
        case .dozen, .lowHigh, .oddEven, .redBlack:
            return .degrees(0)
        }
    }
    
    @ViewBuilder
    private func overlayShape(with type: TableType) -> some View {
        switch type {
        case .zero:
            ZeroShape().stroke(Color.white, lineWidth: 1.5)
        default:
            Rectangle().stroke(Color.white, lineWidth: 1.5)
        }
    }
}
