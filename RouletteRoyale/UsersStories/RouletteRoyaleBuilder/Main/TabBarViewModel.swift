//
//  TabBarViewModel.swift
//  RouletteRoyale
//
//  Created by Dmytro Grytsenko on 17.08.2023.
//

import Foundation
import Firebase
import FirebaseDatabase
import FirebaseCore

final class TabBarViewModel: ObservableObject {
 
//    func getCurrentUser() {
//        guard let userId = FirebaseService.shared.currentUserId else { return }
//
//        FirebaseService.shared.getUserData(userId: userId) { [weak self] result in
//            guard let self = self else { return }
//
//            switch result {
//            case .success(let userData):
//                self.currentUser = userData
//            case .failure(let userDataError):
//                print("DEBUG: Error getting current user data: \(userDataError.localizedDescription)")
//            }
//        }
//    }
//
//    func updateChips(amount: Int) {
//        guard let userId = FirebaseService.shared.currentUserId else { return }
//
//        FirebaseService.shared.updateUserChips(userId: userId, newChipsAmount: amount) { result in
//            switch result {
//            case .success:
//                print("DEBUG: User chips updated successfully")
//            case .failure(let updateChipsError):
//                print("DEBUG: Error updating user chips: \(updateChipsError.localizedDescription)")
//            }
//        }
//    }

//private var userDataObserverHandle: DatabaseHandle?
//   
//   func getCurrentUser() {
//       guard let userId = FirebaseService.shared.currentUserId else { return }
//
//       // Получаем данные пользователя сразу
//       FirebaseService.shared.getUserData(userId: userId) { [weak self] result in
//           guard let self = self else { return }
//
//           switch result {
//           case .success(let userData):
//               self.currentUser = userData
//
//               // Добавляем слушателя на изменения данных пользователя
//               self.userDataObserverHandle = FirebaseService.shared.observeUserData(userId: userId) { userDataResult in
//                   if case .success(let updatedUserData) = userDataResult {
//                       // Обновляем данные при получении обновления
//                       self.currentUser = updatedUserData
//                   }
//               }
//           case .failure(let userDataError):
//               print("DEBUG: Error getting current user data: \(userDataError.localizedDescription)")
//           }
//       }
//   }
//
//    deinit {
//        if let handle = userDataObserverHandle {
//            FirebaseService.shared.removeObserver(handle)
//        }
//    }
    
    
}
