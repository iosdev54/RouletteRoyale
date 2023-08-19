//
//  GameView.swift
//  RouletteRoyale
//
//  Created by Dmytro Grytsenko on 18.08.2023.
//

import SwiftUI

struct GameView: View {
    @StateObject private var viewModel = GameViewModel()
    @EnvironmentObject var userData: UserData
    
    @State private var betType: BetType = .none
    @State private var number: Int = 36
    
    @State private var bet = 10
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                UserView(userData: userData, background: .teal)
                    .animation(.easeInOut, value: userData)
                
                HStack(spacing: 40) {
                    VStack(spacing: 5) {
                        Text("BET")
                        Stepper("Bet", value: $bet, in: 1...10, step: 1)
                            .labelsHidden()
                        Text(String(bet))
                    }
                    .font(.title.bold())
                    .foregroundColor(.yellow)
                    
                    Button(action: startGame) {
                        Text("START")
                            .font(.title.bold())
                            .foregroundColor(.white)
                    }
                    .padding()
                    .padding(.horizontal)
                    .background(betType == .none ? .gray : .red)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .disabled(betType == .none ? true : false)
                }
            }
            .padding(.horizontal)
            
            GeometryReader { proxy in
                    VStack {
                        Wheel(number: $number, onSuccess: { })
                            .frame(width: proxy.size.width * 0.7, height: proxy.size.width * 0.7)
                            .offset(x: 10)
                        
                        TableView(betType: $betType, width: proxy.size.width, height: 250)
                    }
            }
            .padding(.horizontal)
        }
        .background(.green)
    }
    
    private func startGame() {
        number = Int.random(in: 0...36)
        print(number)
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
            .environmentObject(UserData())
    }
}
