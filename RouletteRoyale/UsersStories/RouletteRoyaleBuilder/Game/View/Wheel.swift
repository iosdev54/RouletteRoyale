//
//  Wheel.swift
//  RouletteRoyale
//
//  Created by Dmytro Grytsenko on 18.08.2023.
//

import SwiftUI

struct Wheel: View {
    @Binding var wheelAngle : Int
    
    var body: some View {
        HStack {
            Image("Roulette")
                .resizable()
                .scaledToFit()
                .frame(minWidth: 100, maxWidth: .infinity, minHeight: 100, maxHeight: .infinity)
                .rotationEffect(.degrees(Double(wheelAngle + 4)), anchor: .center)
                .animation(.easeInOut(duration: 2), value: wheelAngle)
            
            Arrow()
                .fill(.red)
                .frame(width: 35, height: 25)
        }
    }
}

struct Wheel_Previews: PreviewProvider {
    static var previews: some View {
        Wheel(wheelAngle: .constant(0))
    }
}
