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
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                UserView(userData: viewModel.userData, background: .teal)
                    .animation(.easeInOut, value: viewModel.userData)
                
                HStack(spacing: 40) {
                    VStack(spacing: 5) {
                        Text("BET")
                        Stepper("Bet", value: $viewModel.bet, in: 1...10, step: 1)
                            .labelsHidden()
                        Text(String(viewModel.bet))
                    }
                    .font(.title.bold())
                    .foregroundColor(.yellow)
                    
                    Button(action: viewModel.startGame) {
                        Text("START")
                            .font(.title.bold())
                            .foregroundColor(.white)
                    }
                    .padding()
                    .padding(.horizontal)
                    .background(viewModel.betType == .none || viewModel.isSpinning ? .gray : .red)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .disabled(viewModel.betType == .none || viewModel.isSpinning ? true : false)
                }
            }
            .padding(.horizontal)
            
            GeometryReader { proxy in
                VStack {
                    WheelView(number: $viewModel.number) {
                        viewModel.checkBet(betType: viewModel.betType, winningNumber: viewModel.number, betAmount: viewModel.betAmount)
                        
                    }
                    .frame(width: proxy.size.width * 0.7, height: proxy.size.width * 0.7)
                    .offset(x: 10)
                    
                    TableView(betType: $viewModel.betType, width: proxy.size.width, height: 250)
                }
            }
            .padding(.horizontal)
        }
        .background(
            Image("gameBackground")
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
