//
//  GameView.swift
//  RouletteRoyale
//
//  Created by Dmytro Grytsenko on 18.08.2023.
//

import SwiftUI

struct GameView: View {
    @StateObject private var viewModel: GameViewModel
    
    init(viewModel: GameViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    private var backgroundImage: Image {
        Constants.Images.gameBackground
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                UserView(userData: viewModel.userData, background: .teal)
                    .animation(.easeInOut, value: viewModel.userData)
                
                BetControlsView(bet: $viewModel.bet, startGame: viewModel.startGame, canStartGame: viewModel.canStartGame)
            }
            .padding(.horizontal)
            
            GeometryReader { proxy in
                VStack {
                    WheelView(number: $viewModel.number) {
                        viewModel.checkBet(betType: viewModel.betType, winningNumber: viewModel.number, betAmount: viewModel.betAmount)
                        
                    }
                    .frame(width: proxy.size.width * 0.7, height: proxy.size.width * 0.7)
                    .padding(.leading, 10)
                    
                    TableView(betType: $viewModel.betType, width: proxy.size.width, height: 250)
                }
            }
            .padding(.horizontal)
        }
        .background(
            backgroundImage
                .resizable()
                .ignoresSafeArea()
        )
        .overlay {
            if let result = viewModel.feedback {
                ResultView(result: result, closeAction: {
                    viewModel.feedback = nil
                })
            }
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(viewModel: GameViewModel(userData: UserData()))
            .environmentObject(UserData())
    }
}
