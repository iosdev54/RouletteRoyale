//
//  SignUpViewModel.swift
//  RouletteRoyale
//
//  Created by Dmytro Grytsenko on 16.08.2023.
//

import Foundation

final class SignUpViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var name = ""
    
    @Published var isLoading = false
    @Published var error: InputError?
    
    var onSuccess: () -> Void
    
    init(onSuccess: @escaping () -> Void) {
        self.onSuccess = onSuccess
    }
    
    func signUp() {
        isLoading = true
        
        FirebaseService.shared.signUpWithEmail(email: email, password: password, name: name) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.isLoading = false
                
                switch result {
                case .success:
                    self.onSuccess()
                    print("DEBUG: User successfully registered")
                case .failure(let signUpError):
                    self.error = InputError(message: signUpError.localizedDescription)
                    print("DEBUG: Error signing up: \(signUpError.localizedDescription)")
                }
            }
        }
    }
}
