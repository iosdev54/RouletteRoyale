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
    @Environment(\.horizontalSizeClass) var sizeClass
    
    @State private var num = -1
    
    var body: some View {
        GeometryReader { proxy in
            VStack {
                Wheel(wheelAngle: $viewModel.wheelAngle)
                    .frame(width: proxy.size.width * 0.6)
                
                
                Button("RUN") {
                    viewModel.wheelAngle += Int.random(in: 1080...1440)
                }
                
                TableView(num: $num, width: proxy.size.width * 0.95, height: 240)
                
                Spacer()
            }
            .frame(maxWidth: .infinity)
        }
        .background(.green)
        
        
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
