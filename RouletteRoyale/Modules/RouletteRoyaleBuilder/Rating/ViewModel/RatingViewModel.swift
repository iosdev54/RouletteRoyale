//
//  RatingViewModel.swift
//  RouletteRoyale
//
//  Created by Dmytro Grytsenko on 17.08.2023.
//

import Foundation

final class RatingViewModel: ObservableObject {
    @Published var users: [UserData] = []
    @Published var error: InputError?
    
    func getAllUsersData() {
        FirebaseService.shared.getAllUsersData { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let fetchedUsers):
                self.users = fetchedUsers
                print("Users received")
            case .failure(let fetchingUsersError):
                error = InputError(message: fetchingUsersError.localizedDescription)
                print("DEBUG: Error fetching users: \(fetchingUsersError.localizedDescription)")
            }
        }
    }
}

