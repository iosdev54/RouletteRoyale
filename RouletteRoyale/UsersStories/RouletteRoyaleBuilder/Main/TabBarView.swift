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
    
    private var backgroundImage: Image {
        Constants.Images.gameBackground
    }
    
    var body: some View {
        TabView {
            GameView(viewModel: GameViewModel(userData: userData))
                .tabItem {
                    Label("Game", systemImage: "gamecontroller")
                }
                .background(
                    backgroundImage
                        .resizable()
                        .ignoresSafeArea()
                )
            
            RatingView()
                .tabItem {
                    Label("Rating", systemImage: "star")
                }
                .background(
                    backgroundImage
                        .resizable()
                        .ignoresSafeArea()
                )
            
            SettingsView(isLoggedIn: $isLoggedIn)
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
                .background(
                    backgroundImage
                        .resizable()
                        .ignoresSafeArea()
                )
        }
        .onAppear(perform: setupTabBar)
        .tint(Constants.tabBarItemTintColor)
        .environmentObject(userData)
    }
    
    private func setupTabBar() {
        UITabBar.appearance().barTintColor = Constants.tabBarBackgroundColor
        UITabBar.appearance().backgroundColor =  Constants.tabBarBackgroundColor
        UITabBar.appearance().unselectedItemTintColor = Constants.tabBarUnselectedItemTintColor
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView(isLoggedIn: .constant(false))
            .environmentObject(UserData())
    }
}
