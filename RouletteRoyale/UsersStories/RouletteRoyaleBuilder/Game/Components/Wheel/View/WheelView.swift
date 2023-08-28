//
//  WheelView.swift
//  RouletteRoyale
//
//  Created by Dmytro Grytsenko on 18.08.2023.
//

import SwiftUI

struct WheelView: View {
    private struct Arrow: Shape {
        func path(in rect: CGRect) -> Path {
            var path = Path()
            path.move(to: CGPoint(x: rect.minX, y: rect.midY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            path.closeSubpath()
            return path
        }
    }
    
    @Binding var number: Int
    var onSuccess: () -> Void
    
    @StateObject private var viewModel: WheelViewModel
    
    init(number: Binding<Int>, onSuccess: @escaping () -> Void) {
        self._viewModel = StateObject(wrappedValue: WheelViewModel(number: number, onSuccess: onSuccess))
        self._number = number
        self.onSuccess = onSuccess
    }
    
    private var rouletteImage: Image {
        Constants.Images.rouletteImage
    }
    
    private var coloredArrow: some View {
        Arrow()
            .fill(
                RadialGradient(
                    gradient: Gradient(colors: [.red, .yellow]),
                    center: .leading,
                    startRadius: 0,
                    endRadius: 50
                )
            )
    }
    
    var body: some View {
        HStack {
            rouletteImage
                .resizable()
                .scaledToFit()
                .rotationEffect(.degrees(Double(viewModel.angle + 3)), anchor: .center)
                .animation(.easeInOut(duration: viewModel.isSpinning ? 3 : 0))
                .shadow(radius: 5)
            
            coloredArrow
                .frame(width: 30, height: 15)
                .shadow(radius: 5)
        }
        .onChange(of: number) { _ in viewModel.startSpinning() }
    }
}

struct WheelView_Previews: PreviewProvider {
    static var previews: some View {
        WheelView(number: .constant(5), onSuccess: {})
    }
}
