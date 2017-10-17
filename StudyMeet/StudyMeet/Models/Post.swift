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
    
    // Properties
    let date: String
    let postDescription: String
    let postTitle: String
    let creatorUid: String
    let schoolName: String
    let studySubject: String
    var members: [String]
    
    init(date: String, postDescription: String, postTitle: String, creatorUid: String, schoolName: String, studySubject: String, members: [String] = []){
        self.date = date
        self.postDescription = postDescription
        self.postTitle = postTitle
        self.creatorUid = creatorUid
        self.schoolName = schoolName
        self.studySubject = studySubject
        self.members = members
    }
    
    init?(postsDictionary: [String:Any]) {
        guard let date = postsDictionary[dateKey] as? String,
            let postDescription = postsDictionary[postDescriptionKey] as? String,
            let postTitle = postsDictionary[postTitleKey] as? String,
            let schoolName = postsDictionary[schoolNameKey] as? String,
            let creatorUid = postsDictionary[creatorUidKey] as? String,
            let studySubject = postsDictionary[studySubjectKey] as? String,
            let members = postsDictionary[membersKey] as? [String] else {return nil}
        
        self.date = date
        self.postDescription = postDescription
        self.postTitle = postTitle
        self.schoolName = schoolName
        self.studySubject = studySubject
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
            creatorUidKey: creatorUid,
            membersKey: members
        ]
        return dictionary
    }
    
    var jsonData: Data? {
        return try? JSONSerialization.data(withJSONObject: dictionaryRepresentaion, options: .prettyPrinted)
    }
}
