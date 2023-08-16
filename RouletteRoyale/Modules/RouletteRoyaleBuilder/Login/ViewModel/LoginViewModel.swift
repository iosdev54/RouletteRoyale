//
//  LoginViewModel.swift
//  RouletteRoyale
//
//  Created by Dmytro Grytsenko on 16.08.2023.
//

import Foundation

final class LoginViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    
    @Published var isLoading = false
    @Published var error: InputError?
    
    var onSuccess: () -> Void
    
    init(onSuccess: @escaping () -> Void) {
        self.onSuccess = onSuccess
    }
    
    func signIn() {
        isLoading = true
        
        FirebaseService.shared.signInWithEmail(email: email, password: password) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.isLoading = false
                
                switch result {
                case .success:
                    self.onSuccess()
                    print("DEBUG: User logged in successfully")
                case .failure(let loginError):
                    self.error = InputError(message: loginError.localizedDescription)
                    print("DEBUG: Error signing in: \(loginError.localizedDescription)")
                }
            }
        }
    }
}
