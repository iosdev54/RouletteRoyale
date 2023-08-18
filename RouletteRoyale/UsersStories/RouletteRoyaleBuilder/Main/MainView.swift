//
//  MainView.swift
//  RouletteRoyale
//
//  Created by Dmytro Grytsenko on 16.08.2023.
//

import SwiftUI

struct MainView: View {
    @State private var isLoggedIn = false
    
    var body: some View {
        Group {
            if isLoggedIn {
                TabBarView(isLoggedIn: $isLoggedIn)
            } else {
                AuthenticationControlView(isLoggedIn: $isLoggedIn)
            }
        }
        .onAppear {
            checkUserAuthenticationStatus()
        }
    }
    
    private func checkUserAuthenticationStatus() {
        isLoggedIn = FirebaseService.shared.isUserLoggedIn()
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
