//
//  User.swift
//  StudyMeet
//
//  Created by Sergio Gamez on 10/9/17.
//  Copyright © 2017 Sergio Gamez. All rights reserved.
//

import Foundation

class User {
    
    // MARK: - Private Keys
    private let firstNameKey = "firstName"
    private let lastNameKey = "lastName"
    private let bioKey = "bio"
    private let emailKey = "email"
    private let passwordKey = "password"
    private let phoneNumberKey = "phoneNumber"
    private let schoolNameKey = "schoolName"
    private let userNameKey = "userName"
    private let uuidKey = "uuid"
    
    // MARK: - Properties
    let firstName: String
    let lastName: String
    let bio: String
    let email: String
    let password: String
    let phoneNumber: String
    let schoolName: String
    let userName: String
    let identifier: String
    
    // Memberwise INIT
    init(firstName: String, lastName: String, bio: String, email: String, password: String, phoneNumber: String, schoolName: String, userName: String, identifier: String) {
        
        self.firstName = firstName
        self.lastName = lastName
        self.bio = bio
        self.email = email
        self.password = password
        self.phoneNumber = phoneNumber
        self.schoolName = schoolName
        self.userName = userName
        self.identifier = identifier
    }
    
    // Failable INIT
    init?(userDictionary: [String:Any], identifier: String) {
        guard let firstName = userDictionary[firstNameKey] as? String,
        let lastName = userDictionary[lastNameKey] as? String,
        let bio = userDictionary[bioKey] as? String,
        let email = userDictionary[emailKey] as? String,
        let password = userDictionary[passwordKey] as? String,
        let phoneNumber = userDictionary[phoneNumberKey] as? String,
        let schoolName = userDictionary[schoolNameKey] as? String,
        let userName = userDictionary[userNameKey] as? String,
        let uuid = userDictionary[uuidKey] as? String else {return nil}
        
        self.firstName = firstName
        self.lastName = lastName
        self.bio = bio
        self.email = email
        self.password = password
        self.phoneNumber = phoneNumber
        self.schoolName = schoolName
        self.userName = userName
        self.identifier = uuid
    }
    
    var dictionaryRepresention: [String:Any] {
        let dictionary: [String:Any] = [
        firstNameKey: firstName,
        lastNameKey: lastName,
        bioKey: bio,
        emailKey: email,
        passwordKey: password,
        phoneNumberKey: phoneNumber,
        schoolNameKey: schoolName,
        userNameKey: userName,
        uuidKey: identifier
        ]
        return dictionary
    }
    
//    // PUT
//    var jsonData: Data? {
//        return try? JSONSerialization.data(withJSONObject: dictionaryRepresention, options: .prettyPrinted)
//    }
}

