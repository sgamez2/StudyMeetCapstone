//
//  PostController.swift
//  StudyMeet
//
//  Created by Sergio Gamez on 10/10/17.
//  Copyright © 2017 Sergio Gamez. All rights reserved.
//

import Foundation
import FirebaseDatabase

class PostController {
    
    static let shared = PostController()
    var posts = [Post]()
    let postRef = Database.database().reference()
    
    func newPost(with date: String, postDescription: String, postTitle: String, schoolName: String, creatorUid: String, studySubject: String, subcategorySubject: String, members: [String] , completion: @escaping (_ success: Bool) -> Void) {
        
        let post = Post(date: date, postDescription: postDescription, postTitle: postTitle, creatorUid: creatorUid, schoolName: schoolName, studySubject: studySubject, subcategorySubject: subcategorySubject, members: members)
        guard let currentUser = StudentController.shared.currentStudent else { return }
        postRef.child("Posts").child(currentUser.identifier).setValue(post.dictionaryRepresentaion)
        completion(true)
    }
    
    func fetchPosts(by genSubject: String) {
        guard let currentStudent = StudentController.shared.currentStudent else { return }
            self.postRef.child("Posts").observeSingleEvent(of: .value, with: { (snapshot) in
            guard let postsDictionary = snapshot.value as? [String:Any],
            let post = Post(postsDictionary: postsDictionary) else {return}
            self.posts.append(post)
            })
    }
}
