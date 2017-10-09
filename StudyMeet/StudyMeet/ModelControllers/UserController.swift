//
//  UserController.swift
//  StudyMeet
//
//  Created by Sergio Gamez on 10/9/17.
//  Copyright © 2017 Sergio Gamez. All rights reserved.
//

import Foundation

class UserController {
    
    static var user = [User]()
    
    static let baseURL = URL(string: "https://studymeet-fc082.firebaseio.com/")
    
    static func newUser(with firstName: String, lastName: String,
                        bio: String, email: String, phoneNumber: Int, schoolName: String, userName: String,
                        completion: @escaping (_ succes: Bool) -> Void){
        
        let user = User(firstName: firstName, lastName: lastName, bio: bio, email: email, phoneNumber: phoneNumber, schoolName: schoolName, userName: userName)
        
    }
}
