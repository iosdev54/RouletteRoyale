//
//  WheelViewModel.swift
//  RouletteRoyale
//
//  Created by Dmytro Grytsenko on 28.08.2023.
//

import SwiftUI

final class WheelViewModel: ObservableObject {
    @Binding var number: Int
    var onSuccess: () -> Void
    
    @Published private(set) var angle: Double = 0.0
    @Published private(set) var isSpinning = false
    
    init(number: Binding<Int>, onSuccess: @escaping () -> Void) {
        self._number = number
        self.onSuccess = onSuccess
    }
    
    func startSpinning() {
        if let selectedNumberIndex = GameConstants.numbers.firstIndex(of: number) {
            let degreesPerNumber = 360.0 / Double(GameConstants.numbers.count)
            let targetAngle = Double(selectedNumberIndex) * degreesPerNumber
            
            let additionalRotation = 1080.0
            
            withAnimation {
                isSpinning = true
                angle = targetAngle + additionalRotation
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
                guard let `self` = self else { return }
                withAnimation {
                    self.isSpinning = false
                    self.angle = targetAngle
                    self.onSuccess()
                }
            }
        }
    }
}
