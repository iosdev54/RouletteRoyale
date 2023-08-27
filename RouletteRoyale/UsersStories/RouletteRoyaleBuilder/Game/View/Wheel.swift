//
//  Wheel.swift
//  RouletteRoyale
//
//  Created by Dmytro Grytsenko on 18.08.2023.
//

import SwiftUI

struct Wheel: View {
    @Binding var number: Int
    var onSuccess: () -> Void
    
    @State private var angle: Double = 0.0
    @State private var isSpinning = false
    
    
    private let numbers = [34, 17, 25, 2, 21, 4, 19, 15, 32, 0, 26, 3, 35, 12, 28, 7, 29, 18, 22, 9, 31, 14, 20, 1, 33, 16, 24 ,5, 10, 23, 8, 30, 11, 36, 13, 27, 6]
    
    var body: some View {
        HStack {
            Image("roulette")
                .resizable()
                .scaledToFit()
                .frame(minWidth: 100, maxWidth: .infinity, minHeight: 100, maxHeight: .infinity)
                .rotationEffect(.degrees(Double(angle + 3)), anchor: .center)
                .animation(.easeInOut(duration: isSpinning ? 3 : 0))
            
            Arrow()
                .fill(.red)
                .frame(width: 35, height: 25)
        }
        .onChange(of: number) { _ in startSpinning() }
    }
    
    func startSpinning() {
        if let selectedNumberIndex = numbers.firstIndex(of: number) {
            let degreesPerNumber = 360.0 / Double(numbers.count)
            let targetAngle = Double(selectedNumberIndex) * degreesPerNumber
            
            let additionalRotation = 1080.0
            
            withAnimation {
                isSpinning = true
                angle = targetAngle + additionalRotation
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                withAnimation {
                    isSpinning = false
                    angle = targetAngle
                    onSuccess()
                }
            }
        }
    }
}

struct Wheel_Previews: PreviewProvider {
    static var previews: some View {
        Wheel(number: .constant(5), onSuccess: {})
    }
}
