//
//  SettingsViewModel.swift
//  RouletteRoyale
//
//  Created by Dmytro Grytsenko on 16.08.2023.
//

import SwiftUI
import StoreKit

final class SettingsViewModel: ObservableObject {
    @Published var userData: UserData?
    
    @Published var isLoadingRateApp = false
    @Published var isLoadingShareApp = false
    @Published var isLoadingLogOut = false
    @Published var isLoadingDeleteAccount = false
    
    @Published var error: InputError?
    
//    func getUserData() {
//        guard let userId = FirebaseService.shared.currentUserId else { return }
//
//        FirebaseService.shared.getUserData(userId: userId) { [weak self] result in
//            guard let self = self else { return }
//
//            switch result {
//            case .success(let userData):
//                self.userData = userData
//            case .failure(let userDataError):
//                error = InputError(message: userDataError.localizedDescription)
//                print("DEBUG: Error getting user data: \(userDataError.localizedDescription)")
//            }
//        }
//    }
    
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
                    print("DEBUG: User logged out successfully")
                case .failure(let signOutError):
                    self.error = InputError(message: signOutError.localizedDescription)
                    print("DEBUG: Error signing out: \(signOutError.localizedDescription)")
                }
            }
        }
    }
    
    func deleteAccount(onSuccess: @escaping () -> Void) {
        isLoadingDeleteAccount = true
        
        FirebaseService.shared.deleteAccount { [weak self] result in
            DispatchQueue.main.async { [weak self] in
                guard let `self` = self else { return }
                self.isLoadingDeleteAccount = false
                
                switch result {
                case .success:
                    onSuccess()
                    print("DEBUG: User account deleted successfully")
                case .failure(let deleteError):
                    error = InputError(message: deleteError.localizedDescription)
                    print("DEBUG: Error deleting user account: \(deleteError.localizedDescription)")
                }
            }
        }
    }
}
