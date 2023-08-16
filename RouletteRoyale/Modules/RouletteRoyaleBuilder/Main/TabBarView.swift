//
//  TabBarView.swift
//  RouletteRoyale
//
//  Created by Dmytro Grytsenko on 16.08.2023.
//

import SwiftUI

struct TabBarView: View {
    @Binding var isLoggedIn: Bool
    
    var body: some View {
        TabView {
            Text("Game")
//            GameView()
                .tabItem {
                    Label("Game", systemImage: "gamecontroller")
                }
            
            Text("Rating")
//            RatingView()
                .tabItem {
                    Label("Rating", systemImage: "star")
                }
            
            SettingsView(isLoggedIn: $isLoggedIn)
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
        }
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView(isLoggedIn: .constant(false))
    }
}
