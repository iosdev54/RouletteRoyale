//
//  ResultView.swift
//  RouletteRoyale
//
//  Created by Dmytro Grytsenko on 19.08.2023.
//

import SwiftUI

struct ResultView: View {
    let result: BetResult
    let closeAction: () -> Void
    
    @State private var isAnimating = false
    
    private let animationDuration: Double = 0.25
    private var appearAnimation: Animation {
        Animation.easeInOut(duration: animationDuration)
    }
    
    var body: some View {
        VStack(spacing: 5) {
            Text(result.win ? "You Won!" : "You Lost!")
                .font(.title)
                .foregroundColor(result.win ? .green : .red)
            
            Text(String(result.amount))
                .font(.title)
        }
        .padding()
        .background(.ultraThinMaterial)
        .cornerRadius(10)
        .shadow(radius: 5)
        .scaleEffect(isAnimating ? 1.0 : 0.5)
        .opacity(isAnimating ? 1.0 : 0.0)
        .animation(appearAnimation, value: isAnimating)
        .onAppear {
            withAnimation(appearAnimation) {
                isAnimating = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                withAnimation(appearAnimation) {
                    isAnimating = false
                    closeAction()
                }
            }
        }
    }
}

struct ResultView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Constants.Images.gameBackground
                .resizable()
                .ignoresSafeArea()
            
            ResultView(result: BetResult(win: true, amount: 230), closeAction: {})
        }
    }
}
