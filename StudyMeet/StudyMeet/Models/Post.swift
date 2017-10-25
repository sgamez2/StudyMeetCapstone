//
//  Post.swift
//  StudyMeet
//
//  Created by Sergio Gamez on 10/10/17.
//  Copyright © 2017 Sergio Gamez. All rights reserved.
//

import Foundation

class Post {
    
    // Private Keys
    private let dateKey = "date"
    private let postDescriptionKey = "postDescription"
    private let postTitleKey = "postTitle"
    private let schoolNameKey = "schoolName"
    private let membersKey = "members"
    private let creatorUidKey = "creatorUid"
    private let studySubjectKey = "studySubject"
    private let subcategorySubjectKey = "subcategorySubject"
    private let addressNameKey = "adressName"
    private let addressKey = "address"
    
    // Properties
    let date: String
    let postDescription: String
    let postTitle: String
    let creatorUid: String
    let schoolName: String
    let studySubject: String
    let subcategorySubject: String
    let addressName: String
    let address: String
    var members: [String]
    
    init(date: String, postDescription: String, postTitle: String, creatorUid: String, schoolName: String, studySubject: String, subcategorySubject: String, addressName: String, address: String, members: [String] = []){
        self.date = date
        self.postDescription = postDescription
        self.postTitle = postTitle
        self.creatorUid = creatorUid
        self.schoolName = schoolName
        self.studySubject = studySubject
        self.subcategorySubject = subcategorySubject
        self.addressName = addressName
        self.address = address
        self.members = members
    }
    
    init?(postsDictionary: [String:Any]) {
        guard let date = postsDictionary[dateKey] as? String,
            let postDescription = postsDictionary[postDescriptionKey] as? String,
            let postTitle = postsDictionary[postTitleKey] as? String,
            let schoolName = postsDictionary[schoolNameKey] as? String,
            let creatorUid = postsDictionary[creatorUidKey] as? String,
            let studySubject = postsDictionary[studySubjectKey] as? String,
            let subcategorySubject = postsDictionary[subcategorySubjectKey] as? String,
            let addressName = postsDictionary[addressNameKey] as? String,
            let address = postsDictionary[addressKey] as? String,
            let members = postsDictionary[membersKey] as? [String] else {return nil}
        
        self.date = date
        self.postDescription = postDescription
        self.postTitle = postTitle
        self.schoolName = schoolName
        self.studySubject = studySubject
        self.subcategorySubject = subcategorySubject
        self.addressName = addressName
        self.address = address
        self.creatorUid = creatorUid
        self.members = members
    }
    
    var dictionaryRepresentaion: [String:Any] {
        let dictionary: [String:Any] = [
            dateKey: date,
            postDescriptionKey: postDescription,
            postTitleKey: postTitle,
            schoolNameKey: schoolName,
            studySubjectKey: studySubject,
            subcategorySubjectKey: subcategorySubject,
            addressNameKey: addressName,
            addressKey: address,
            creatorUidKey: creatorUid,
            membersKey: members
        ]
        return dictionary
    }
}
