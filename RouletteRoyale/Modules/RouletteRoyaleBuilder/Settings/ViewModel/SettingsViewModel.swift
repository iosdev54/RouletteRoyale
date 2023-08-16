//
//  SettingsViewModel.swift
//  RouletteRoyale
//
//  Created by Dmytro Grytsenko on 16.08.2023.
//

import SwiftUI

final class SettingsViewModel: ObservableObject {
    @Published var isLoadingRateApp = false
    @Published var isLoadingShareApp = false
    @Published var isLoadingLogOut = false
    @Published var isLoadingDeleteAccount = false
    
    @Published var error: InputError?
    
    func rateApp() {
        if let url = URL(string: "itms-apps://itunes.apple.com/app/idYOUR_APP_ID") {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    func showActivityVC() {
        let activityViewController = UIActivityViewController(
            activityItems: ["RouletteRoyale is an awesome app!"],
            applicationActivities: nil
        )
        UIApplication.shared.windows.first?.rootViewController?.present(
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
