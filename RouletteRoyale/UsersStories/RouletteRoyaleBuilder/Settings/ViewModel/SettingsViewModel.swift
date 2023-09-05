//
//  SettingsViewModel.swift
//  RouletteRoyale
//
//  Created by Dmytro Grytsenko on 16.08.2023.
//

import SwiftUI
import StoreKit

final class SettingsViewModel: ObservableObject {
    @Published var isLoadingLogOut = false
    @Published var showDeleteConfirmation = false
    @Published var error: InputError?
    
    func rateApp() {
        if let scene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
            SKStoreReviewController.requestReview(in: scene)
        }
    }
    
    func showActivityVC() {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let mainWindow = windowScene.windows.first else {
            return
        }
        
        let activityViewController = UIActivityViewController(
            activityItems: ["RouletteRoyale is an awesome app!"],
            applicationActivities: nil
        )
        
        mainWindow.rootViewController?.present(
            activityViewController,
            animated: true,
            completion: nil
        )
    }
    
    func logOut(onSuccess: @escaping () -> Void) {
        isLoadingLogOut = true
        
        FirebaseService.shared.signOut { result in
            DispatchQueue.main.async { [weak self] in
                guard let `self` = self else { return }
                
                self.isLoadingLogOut = false
                
                switch result {
                case .success:
                    onSuccess()
                    debugPrint("DEBUG: User logged out successfully")
                case .failure(let signOutError):
                    self.error = InputError(message: signOutError.localizedDescription)
                    debugPrint("DEBUG: Error signing out: \(signOutError.localizedDescription)")
                }
            }
        }
    }
    
    func deleteAccount(onSuccess: @escaping () -> Void) {
        FirebaseService.shared.deleteAccount { [weak self] result in
            DispatchQueue.main.async {
                guard let `self` = self else { return }
                
                switch result {
                case .success:
                    onSuccess()
                    debugPrint("DEBUG: User account deleted successfully")
                case .failure(let deleteError):
                    self.error = InputError(message: deleteError.localizedDescription)
                    debugPrint("DEBUG: Error deleting user account: \(deleteError.localizedDescription)")
                }
            }
        }
    }
}
