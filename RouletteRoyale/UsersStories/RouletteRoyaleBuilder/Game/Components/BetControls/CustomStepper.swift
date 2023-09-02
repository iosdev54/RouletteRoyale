//
//  CustomStepper.swift
//  RouletteRoyale
//
//  Created by Dmytro Grytsenko on 01.09.2023.
//

import SwiftUI

struct CustomStepper: View {
    private enum Constants {
        static let minusSignColor: Color = .red
        static let plusSignColor: Color = .green
        static let disabledStateOpacity: Double = 0.5
        static let backgroundColor: Material = .ultraThinMaterial
    }
    
    @Binding var value: Int
    let range: ClosedRange<Int>
    let step: Int
    
    var body: some View {
        HStack(spacing: 25) {
            Button(action: decrement) {
                Image(systemName: "minus")
                    .font(.title.bold())
                    .foregroundColor(
                        value == range.lowerBound ? CustomStepper.Constants.minusSignColor.opacity(CustomStepper.Constants.disabledStateOpacity)
                        : CustomStepper.Constants.minusSignColor)
            }
            .disabled(value <= range.lowerBound)
            
            Button(action: increment) {
                Image(systemName: "plus")
                    .font(.title.bold())
                    .foregroundColor(value == range.upperBound ? CustomStepper.Constants.plusSignColor.opacity(CustomStepper.Constants.disabledStateOpacity) : CustomStepper.Constants.plusSignColor)
            }
            .disabled(value >= range.upperBound)
        }
        .padding(10)
        .foregroundColor(.primary)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(CustomStepper.Constants.backgroundColor)
        )
    }
    
    private func increment() {
        if value < range.upperBound {
            value += step
        }
    }
    
    private func decrement() {
        if value > range.lowerBound {
            value -= step
        }
    }
}

struct CustomStepper_Previews: PreviewProvider {
    static var previews: some View {
        CustomStepper(value: .constant(400), range: 1...10, step: 1)
    }
}
