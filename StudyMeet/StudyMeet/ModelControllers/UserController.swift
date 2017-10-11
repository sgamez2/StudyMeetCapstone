//
//  UserController.swift
//  StudyMeet
//
//  Created by Sergio Gamez on 10/9/17.
//  Copyright © 2017 Sergio Gamez. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth

class UserController {
    
    static let shared = UserController()
    let baseRef = Database.database().reference()
    var users = [User]()
    var currentUser: User?
    
    func newUserWith(firstName: String, lastName: String,
                     bio: String, email: String, password: String, phoneNumber: String, schoolName: String, userName: String,
                     //identifier: String,
                     completion: @escaping (_ success: Bool) -> Void) {
        
        Auth.auth().createUser(withEmail: email, password: password) { (authenticatedUser, error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                guard let authenticatedUser = authenticatedUser else  {return}
                let user = User(firstName: firstName, lastName: lastName, bio: bio, email: email, password: password, phoneNumber: phoneNumber, schoolName: schoolName, userName: userName, identifier: authenticatedUser.uid)
                self.currentUser = user
                self.baseRef.child("Users").child(user.identifier).setValue(user.dictionaryRepresention)
                completion(true)
            }
        }
    }
    
    func fetchUsers(_ uid: String) -> String {
        return ""
    }
}

