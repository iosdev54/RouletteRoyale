//
//  TabBarView.swift
//  RouletteRoyale
//
//  Created by Dmytro Grytsenko on 16.08.2023.
//

import SwiftUI

struct TabBarView: View {
    @Binding var isLoggedIn: Bool
    @StateObject private var userData = UserData()
    
    var body: some View {
        TabView {
            GameView(viewModel: GameViewModel(userData: userData))
                .tabItem {
                    Label("Game", systemImage: "gamecontroller")
                }
            
            RatingView()
                .tabItem {
                    Label("Rating", systemImage: "star")
                }
            
            SettingsView(isLoggedIn: $isLoggedIn)
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
        }
        .environmentObject(userData)
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView(isLoggedIn: .constant(false))
            .environmentObject(UserData())
    }
}
