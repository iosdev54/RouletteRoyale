//
//  RatingViewModel.swift
//  RouletteRoyale
//
//  Created by Dmytro Grytsenko on 17.08.2023.
//

import Foundation

final class RatingViewModel: ObservableObject {
    enum UsersDataLoadingState {
        case loading
        case hasData
        case noData
    }
    
    @Published var users: [UserData] = []
    @Published var loadingState: UsersDataLoadingState = .loading
    @Published var error: InputError?
    
    func getAllUsersData() {
        FirebaseService.shared.getAllUsersData { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let fetchedUsers):
                self.users = fetchedUsers
                self.loadingState = users.isEmpty ? .noData : .hasData
                
                debugPrint("Users received")
                
            case .failure(let fetchingUsersError):
                self.error = InputError(message: fetchingUsersError.localizedDescription)
                self.loadingState = .noData
                
                debugPrint("DEBUG: Error fetching users: \(fetchingUsersError.localizedDescription)")
            }
        }
    }
}

