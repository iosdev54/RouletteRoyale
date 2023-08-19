//
//  ResultView.swift
//  RouletteRoyale
//
//  Created by Dmytro Grytsenko on 19.08.2023.
//

import SwiftUI

struct ResultView: View {
    let result: BetResult
    
    var closeAction: () -> Void
    
    var body: some View {
        VStack(spacing: 5) {
            Text(result.win ? "You Won!" : "You Lost!")
                .font(.title)
                .foregroundColor(result.win ? .green : .red)
            
            Text(String(result.amount))
                .font(.title2)
                .padding(.top, 10)
        }
        .frame(width: 150, height: 100)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
        .transition(.scale)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                closeAction()
            }
        }
    }
}

struct ResultView_Previews: PreviewProvider {
    static var previews: some View {
        ResultView(result: BetResult(win: true, amount: 230), closeAction: {})
    }
}
