//
//  SettingsViewModel.swift
//  RouletteRoyale
//
//  Created by Dmytro Grytsenko on 16.08.2023.
//

import Foundation

final class SettingsViewModel: ObservableObject {
    @Published var isLoading = false
    
    func logOut(onSuccess: @escaping () -> Void) {
        isLoading = true
        
        FirebaseService.shared.signOut {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.isLoading = false
                onSuccess()
            }
        }
    }
}
