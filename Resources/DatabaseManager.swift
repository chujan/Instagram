//
//  DatabaseManager.swift
//  Instagram
//(
//  Created by Jennifer Chukwuemeka on 09/11/2022.
//

import FirebaseDatabase

public class DatabaseManager {
    static let shared = DatabaseManager()
    private let database = Database.database().reference()
    
    public func canCreateNewUser(with email: String, username: String, completion: (Bool) -> Void) {
        completion(true)
        
    }
    //create new user here
    public func insertNewUser(with email: String, username: String, completion: @escaping (Bool) -> Void) {
        let key = email.safeDatabaseKey()
        print(key)
        database.child(key).setValue(["username": username]) { error, _ in
            if error == nil {
                completion(true)
            }
            else {
                completion(false)
                return
            }
            
        }
        
        
    }
    
    
}
