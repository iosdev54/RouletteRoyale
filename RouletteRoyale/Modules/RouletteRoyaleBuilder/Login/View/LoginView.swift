//
//  LoginView.swift
//  RouletteRoyale
//
//  Created by Dmytro Grytsenko on 16.08.2023.
//

import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel: LoginViewModel
    
    init(onSuccess: @escaping () -> Void) {
        self._viewModel = StateObject(wrappedValue: LoginViewModel(onSuccess: onSuccess))
    }
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Welcome to RouletteRoyale")
                .font(.largeTitle)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
            
            VStack(spacing: 15) {
                TextField("Email", text: $viewModel.email)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                
                SecureField("Password", text: $viewModel.password)
                    .textFieldStyle(.roundedBorder)
            }
            .padding(.horizontal)
            
            CustomButton(isLoading: $viewModel.isLoading, title: "Log In", color: .blue, completion: { viewModel.signIn() })
                .disabled(viewModel.isLoading)
                .animation(.easeInOut, value: viewModel.isLoading)
        }
        .padding()
        .alert(item: $viewModel.error) { error in
            Alert(title: Text(error.title), message: Text(error.message))
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(onSuccess: {})
    }
}
