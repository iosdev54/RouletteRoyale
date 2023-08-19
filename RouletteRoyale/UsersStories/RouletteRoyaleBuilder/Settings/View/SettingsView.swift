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
    @EnvironmentObject var userData: UserData
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                UserView(userData: userData)
                    .animation(.easeInOut, value: userData)
                    .padding()
                    .padding(.bottom, geometry.size.width > geometry.size.height ? 0 : 30)
                
                ScrollView {
                    VStack(spacing: geometry.size.width > geometry.size.height ? 15 : 30) {
                        CustomButton(isLoading: $viewModel.isLoadingRateApp, title: "Rate app", color: .green, completion: viewModel.rateApp)
                            .padding(.top, 10)
                        
                        CustomButton(isLoading: $viewModel.isLoadingShareApp, title: "Share App", color: .yellow, completion: viewModel.showActivityVC)
                        
                        CustomButton(isLoading: $viewModel.isLoadingLogOut, title: "Log Out", color: .blue, completion: {
                            viewModel.logOut(onSuccess: { isLoggedIn = false })
                        })
                        .disabled(viewModel.isLoadingLogOut)
                        .animation(.easeInOut, value: viewModel.isLoadingLogOut)
                        
                        CustomButton(isLoading: $viewModel.isLoadingDeleteAccount, title: "Delete Account", color: .red, completion: {
                            viewModel.deleteAccount(onSuccess: { isLoggedIn = false })
                        })
                        .disabled(viewModel.isLoadingDeleteAccount)
                        .animation(.easeInOut, value: viewModel.isLoadingDeleteAccount)
                    }
                    .padding(.horizontal)
                }
            }
            .alert(item: $viewModel.error) { error in
                Alert(title: Text(error.title), message: Text(error.message))
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(isLoggedIn: .constant(false))
            .environmentObject(UserData())
    }
}
