//
//  FirebaseService.swift
//  RouletteRoyale
//
//  Created by Dmytro Grytsenko on 16.08.2023.
//

import Foundation
import Firebase
import FirebaseAuth

class FirebaseService {
    static let shared = FirebaseService()
    
    private init() {}
    
    func isUserLoggedIn() -> Bool {
        return Auth.auth().currentUser != nil
    }
    
    var currentUser: User? {
        return Auth.auth().currentUser
    }
    
    func signInWithEmail(email: String, password: String, completion: @escaping (Result<User?, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(authResult?.user))
            }
        }
    }
    
    func signUpWithEmail(email: String, password: String, name: String, completion: @escaping (Result<User?, Error>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(.failure(error))
            } else {
                let changeRequest = authResult?.user.createProfileChangeRequest()
                changeRequest?.displayName = name
                changeRequest?.commitChanges { error in
                    if let error = error {
                        print("Error updating display name: \(error.localizedDescription)")
                    }
                }
                completion(.success(authResult?.user))
            }
        }
    }
    
    func signOut(completion: () -> Void) {
        do {
            try Auth.auth().signOut()
            completion()
        } catch {
            print("DEBUG: Error signing out")
        }
    }
}
