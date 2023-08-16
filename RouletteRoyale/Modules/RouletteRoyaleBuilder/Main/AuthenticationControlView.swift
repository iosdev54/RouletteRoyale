//
//  AuthenticationControlView.swift
//  RouletteRoyale
//
//  Created by Dmytro Grytsenko on 16.08.2023.
//

import SwiftUI

struct AuthenticationControlView: View {
    @Binding var isLoggedIn: Bool
    
    var body: some View {
        TabView {
            LoginView() { isLoggedIn = true }
                .tabItem {
                    Label("Login", systemImage: "person.fill")
                }
            
            SignUpView() { isLoggedIn = true }
                .tabItem {
                    Label("Sign Up", systemImage: "person.crop.circle.badge.plus")
                }
            
            AnonymousRegistrationView { isLoggedIn = true }
            .tabItem {
                Label("Anonymous", systemImage: "person.fill.questionmark")
            }
        }
    }
}

struct AuthenticationControlView_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticationControlView(isLoggedIn: .constant(false))
    }
}
