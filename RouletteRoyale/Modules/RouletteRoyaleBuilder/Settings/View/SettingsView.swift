//
//  SettingsView.swift
//  RouletteRoyale
//
//  Created by Dmytro Grytsenko on 16.08.2023.
//

import SwiftUI

struct SettingsView: View {
    @StateObject private var viewModel = SettingsViewModel()
    @Binding var isLoggedIn: Bool
    
    var body: some View {
        VStack {
            CustomButton(isLoading: $viewModel.isLoading, title: "Log out", color: .yellow, completion: {
                viewModel.logOut(onSuccess: {isLoggedIn = false })
            })
        }
        .padding()
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(isLoggedIn: .constant(false))
    }
}
