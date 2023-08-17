//
//  ContentView.swift
//  RouletteRoyale
//
//  Created by Dmytro Grytsenko on 16.08.2023.
//

import SwiftUI

struct ContentView: View {
    @State private var isLoggedIn = false
    @StateObject private var userData = UserData()
    
    var body: some View {
        Group {
            if isLoggedIn {
                TabBarView(isLoggedIn: $isLoggedIn)
                    .environmentObject(userData)
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
        ContentView()
    }
}
