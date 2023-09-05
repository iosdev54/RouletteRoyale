//
//  SignUpView.swift
//  RouletteRoyale
//
//  Created by Dmytro Grytsenko on 16.08.2023.
//

import SwiftUI

struct SignUpView: View {
    @StateObject private var viewModel: SignUpViewModel
    
    init(onSuccess: @escaping () -> Void) {
        self._viewModel = StateObject(wrappedValue: SignUpViewModel(onSuccess: onSuccess))
    }
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Create an Account")
                .font(.largeTitle)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
            
            VStack(spacing: 15) {
                TextField("Name", text: $viewModel.name)
                    .textFieldStyle(.roundedBorder)
                
                TextField("Email", text: $viewModel.email)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                
                SecureField("Password", text: $viewModel.password)
                    .textFieldStyle(.roundedBorder)
            }
            
            CustomButton(isLoading: viewModel.isLoading, title: "Sign Up", color: .green, completion: viewModel.signUp)
                .disabled(viewModel.isLoading)
                .animation(.easeInOut, value: viewModel.isLoading)
        }
        .padding()
        .alert(item: $viewModel.error) { error in
            Alert(title: Text(error.title), message: Text(error.message))
        }
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView(onSuccess: {})
    }
}
