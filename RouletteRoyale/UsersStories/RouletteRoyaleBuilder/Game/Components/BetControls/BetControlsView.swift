//
//  BetControlsView.swift
//  RouletteRoyale
//
//  Created by Dmytro Grytsenko on 30.08.2023.
//

import SwiftUI

struct BetControlsView: View {
    private struct BetStepper: View {
        @Binding var bet: Int
        
        var body: some View {
            VStack(spacing: 5) {
                Text("BET")
                
                CustomStepper(value: $bet, range: 1...10, step: 1)
                
                Text(String(bet))
            }
            .font(.title.bold())
            .foregroundColor(.yellow)
        }
    }
    
    private struct StartButton: View {
        let action: () -> Void
        let isEnabled: Bool
        
        var body: some View {
            Button(action: action) {
                Text("START")
            }
            .padding(7)
            .padding(.horizontal, 5)
            .font(.title.bold())
            .foregroundColor(.white)
            .background(isEnabled ? .red : .red.opacity(0.5))
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .disabled(!isEnabled)
        }
    }
    
    @Binding var bet: Int
    
    let startGame: () -> Void
    let canStartGame: Bool
    
    var body: some View {
        HStack(spacing: 40) {
            BetStepper(bet: $bet)
            
            StartButton(action: startGame, isEnabled: canStartGame)
        }
    }
}

struct BetControlsView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Constants.Images.gameBackground
                .resizable()
                .ignoresSafeArea()
            
            BetControlsView(bet: .constant(10), startGame: {}, canStartGame: true)
        }
    }
}
