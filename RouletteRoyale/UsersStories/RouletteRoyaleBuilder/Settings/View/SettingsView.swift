//
//  SettingsView.swift
//  RouletteRoyale
//
//  Created by Dmytro Grytsenko on 16.08.2023.
//

import SwiftUI

struct SettingsView: View {
    private enum ButtonTitle: String {
        case rateApp = "Rate app"
        case shareApp = "Share App"
        case logOut = "Log Out"
        case deleteAccount = "Delete Account"
    }
    
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
                        CustomButton(title: ButtonTitle.rateApp.rawValue, color: .green, completion: viewModel.rateApp)
                            .padding(.top, 10)
                        
                        CustomButton(title: ButtonTitle.shareApp.rawValue, color: .yellow, completion: viewModel.showActivityVC)
                        
                        CustomButton(isLoading: viewModel.isLoadingLogOut, title: ButtonTitle.logOut.rawValue, color: .blue) {
                            viewModel.logOut(onSuccess: { isLoggedIn = false }) }
                        .disabled(viewModel.isLoadingLogOut)
                        .animation(.easeInOut, value: viewModel.isLoadingLogOut)
                        
                        CustomButton(title: ButtonTitle.deleteAccount.rawValue, color: .red) { viewModel.showDeleteConfirmation = true }
                            .confirmationDialog("Delete Account", isPresented: $viewModel.showDeleteConfirmation) {
                                Button("Delete", role: .destructive) {
                                    viewModel.deleteAccount(onSuccess: { isLoggedIn = false })
                                }
                                Button("Cancel", role: .cancel) {}
                            }
                        
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
        ZStack {
            Constants.Images.gameBackground
                .resizable()
                .ignoresSafeArea()
            
            SettingsView(isLoggedIn: .constant(false))
                .environmentObject(UserData())
        }
    }
}
