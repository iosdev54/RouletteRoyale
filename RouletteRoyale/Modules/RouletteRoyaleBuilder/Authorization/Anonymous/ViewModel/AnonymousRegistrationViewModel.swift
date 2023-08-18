//
//  AnonymousRegistrationViewModel.swift
//  RouletteRoyale
//
//  Created by Dmytro Grytsenko on 16.08.2023.
//

import Foundation

class AnonymousRegistrationViewModel: ObservableObject {
    @Published var isLoading = false
    @Published var error: InputError?
    
    var onSuccess: () -> Void
    
    init(onSuccess: @escaping () -> Void) {
        self.onSuccess = onSuccess
    }
    
    func registerAnonymously() {
        isLoading = true
        
        FirebaseService.shared.registerAnonymously { [weak self] result in
            guard let `self` = self else { return }
            
            DispatchQueue.main.async {
                self.isLoading = false
                
                switch result {
                case .success:
                    self.onSuccess()
                    print("DEBUG: User registered anonymously")
                case .failure(let registerAnonymouslyError):
                    self.error = InputError(message: registerAnonymouslyError.localizedDescription)
                    print("DEBUG: Error registering anonymously: \(registerAnonymouslyError.localizedDescription)")
                }
            }
        }
    }
}
