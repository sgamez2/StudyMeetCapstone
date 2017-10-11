//
//  UserController.swift
//  StudyMeet
//
//  Created by Sergio Gamez on 10/9/17.
//  Copyright © 2017 Sergio Gamez. All rights reserved.
//

import Foundation
import FirebaseDatabase

class UserController {
    
    static let shared = UserController()
    let baseRef = Database.database().reference()
    var users = [User]()
    
    func newUserWith(firstName: String, lastName: String,
                     bio: String, email: String, phoneNumber: String, schoolName: String, userName: String,
                     completion: @escaping (_ succes: Bool) -> Void) {
        
        let user = User(firstName: firstName, lastName: lastName, bio: bio, email: email, phoneNumber: phoneNumber, schoolName: schoolName, userName: userName)
        baseRef.child("Users").child(user.identifier.uuidString).setValue(user.dictionaryRepresention)
        completion(true)
    }
}

