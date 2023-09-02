//
//  BackgroundStyle.swift
//  RouletteRoyale
//
//  Created by Dmytro Grytsenko on 01.09.2023.
//

import SwiftUI

enum BackgroundStyle {
    case color(Color)
    case material(Material)
    
    func asColor() -> Color? {
        switch self {
        case .color(let color):
            return color
        default:
            return nil
        }
    }
    
    func asMaterial() -> Material? {
        switch self {
        case .material(let material):
            return material
        default:
            return nil
        }
    }
}

extension View {
    func background(_ style: BackgroundStyle) -> some View {
        Group {
            if let color = style.asColor() {
                self.background(color)
            } else if let material = style.asMaterial() {
                self.background(material)
            }
        }
    }
}
