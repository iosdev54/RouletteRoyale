//
//  ContentView.swift
//  RouletteRoyale
//
//  Created by Dmytro Grytsenko on 16.08.2023.
//

import SwiftUI

struct ContentView: View {
    @State private var isLoggedIn = false {
        didSet {
            print(isLoggedIn)
        }
    }
    
    var body: some View {
        Group {
            if isLoggedIn {
                TabBarView()
            } else {
                AuthenticationControlView(isLoggedIn: $isLoggedIn)
            }
        }
        .onAppear {
//            FirebaseService.shared.configure()
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
