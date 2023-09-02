//
//  UserData.swift
//  RouletteRoyale
//
//  Created by Dmytro Grytsenko on 17.08.2023.
//

import Foundation
import Firebase

final class UserData: Equatable, Comparable, Identifiable, ObservableObject {
    var id = ""
    @Published var name: String  = ""
    @Published var chips: Int = 0 {
        didSet {
            if chips < 100 {
                chips += 100
                saveToFirebase()
            }
        }
    }
    @Published var winRate: Double = 0.0
    @Published var isDataAvailable: Bool = false
    
    init() {
        if let userId = FirebaseService.shared.currentUserId {
            FirebaseService.shared.observeUserDataChanges(userId: userId) { [weak self] result in
                guard let `self` = self else { return }
                
                DispatchQueue.main.async {
                    switch result {
                    case .success(let updatedUserData):
                        self.update(with: updatedUserData)
                        self.isDataAvailable = true
                    case .failure(let error):
                        print("DEBUG: Error observing user data changes: \(error.localizedDescription)")
                    }
                }
            }
        }
    }
    
    init?(snapshot: [String: Any]) {
        guard
            let id = snapshot["id"] as? String,
            let name = snapshot["name"] as? String,
            let chips = snapshot["chips"] as? Int,
            let winRate = snapshot["winRate"] as? Double else {
            return nil
        }
        
        self.id = id
        self.name = name
        self.chips = chips
        self.winRate = winRate
        
        self.isDataAvailable = true
    }
    
    private func update(with userData: UserData) {
        self.id = userData.id
        self.name = userData.name
        self.chips = userData.chips
        self.winRate = userData.winRate
    }
    
    func saveToFirebase() {
        guard let userId = FirebaseService.shared.currentUserId else { return }
        
        let data: [String: Any] = [
            "chips": chips,
            "winRate": winRate
        ]
        
        FirebaseService.shared.updateUserData(userId: userId, data: data) { result in
            switch result {
            case .success:
                print("DEBUG: User data saved to Firebase successfully")
            case .failure(let error):
                print("DEBUG: Error saving user data to Firebase: \(error.localizedDescription)")
            }
        }
    }
    
    static func == (lhs: UserData, rhs: UserData) -> Bool {
        lhs.id == rhs.id
    }
    
    static func < (lhs: UserData, rhs: UserData) -> Bool {
        lhs.chips > rhs.chips
    }
}
