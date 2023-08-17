//
//  FirebaseService.swift
//  RouletteRoyale
//
//  Created by Dmytro Grytsenko on 16.08.2023.
//

import Foundation
import Firebase
import FirebaseAuth
//import FirebaseDatabase

class FirebaseService {
    static let shared = FirebaseService()
    private var databaseRef: DatabaseReference
    
    private init() {
        databaseRef = Database.database().reference()
    }
    
    func isUserLoggedIn() -> Bool {
        return Auth.auth().currentUser != nil
    }
    
    var currentUserId: String? {
        return Auth.auth().currentUser?.uid
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
                guard let user = authResult?.user else {
                    completion(.failure(FirebaseError.invalidUserData))
                    return
                }
                
                let userData: [String: Any] = [
                    "name": name,
                    "chips": 2000,
                    "winRate": 0.0
                ]
                
                let userRef = self.databaseRef.child("users").child(user.uid)
                userRef.setValue(userData) { error, _ in
                    if let error = error {
                        completion(.failure(error))
                    } else {
                        completion(.success((user)))
                    }
                }
            }
        }
    }
    
    func registerAnonymously(completion: @escaping (Result<Void, Error>) -> Void) {
        Auth.auth().signInAnonymously { authResult, error in
            if let error = error {
                completion(.failure(error))
            } else {
                guard let user = authResult?.user else {
                    completion(.failure(FirebaseError.invalidUserData))
                    return
                }
                
                let userData: [String: Any] = [
                    "name": "Anonymous",
                    "chips": 2000,
                    "winRate": 0.0
                ]
                
                let userRef = self.databaseRef.child("users").child(user.uid)
                userRef.setValue(userData) { error, _ in
                    if let error = error {
                        completion(.failure(error))
                    } else {
                        completion(.success(()))
                    }
                }
            }
        }
    }
    
    func signOut(completion: @escaping (Result<Void, Error>) -> Void) {
        do {
            try Auth.auth().signOut()
            completion(.success(()))
        } catch let error {
            completion(.failure(error))
        }
    }
    
    func deleteAccount(completion: @escaping (Result<Void, Error>) -> Void) {
        guard let user = Auth.auth().currentUser else {
            completion(.failure(FirebaseError.noCurrentUser))
            return
        }
        
        let userRef = databaseRef.child("users").child(user.uid)
        
        user.delete { error in
            if let error = error {
                completion(.failure(error))
            } else {
                userRef.removeValue { databaseError, _ in
                    if let databaseError = databaseError {
                        completion(.failure(databaseError))
                    } else {
                        completion(.success(()))
                    }
                }
            }
        }
    }
    
    func getUserData(userId: String, completion: @escaping (Result<UserData, Error>) -> Void) {
        let userRef = databaseRef.child("users").child(userId)
        
        userRef.observeSingleEvent(of: .value) { snapshot in
            if let userDataDict = snapshot.value as? [String: Any],
               let userData = UserData(snapshot: userDataDict) {
                completion(.success(userData))
            } else {
                completion(.failure(FirebaseError.invalidUserData))
            }
        } withCancel: { error in
            completion(.failure(error))
        }
    }
    
    func updateChips(userId: String, newChipsAmount: Int, completion: @escaping (Error?) -> Void) {
        let userRef = databaseRef.child("users").child(userId)
        
        userRef.updateChildValues(["chips": newChipsAmount]) { error, _ in
            completion(error)
        }
    }
}
