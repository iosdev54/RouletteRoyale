//
//  SettingsViewModel.swift
//  RouletteRoyale
//
//  Created by Dmytro Grytsenko on 16.08.2023.
//

import Foundation

final class SettingsViewModel: ObservableObject {
    @Published var isLoading = false
    @Published var error: InputError?
    
    func logOut(onSuccess: @escaping () -> Void) {
        isLoading = true
        
        FirebaseService.shared.signOut { result in
            DispatchQueue.main.async { [weak self] in
                guard let `self` = self else { return }
                self.isLoading = false
                
                switch result {
                case .success:
                    onSuccess()
                    print("DEBUG: User logged out successfully")
                case .failure(let signOutError):
                    self.error = InputError(message: signOutError.localizedDescription)
                    print("DEBUG: Error signing out: \(signOutError.localizedDescription)")
                }
            }
        }
    }
}
