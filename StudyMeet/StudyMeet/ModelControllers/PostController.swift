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
    var allPosts = [Post]()
    var studentPosts = [Post]()
    var joinedPosts = [Post]()
    let postRef = Database.database().reference()
    
    
    // MARK: - METHODS
    
    // Creating a new Post
    func newPost(with date: String, postDescription: String, postTitle: String, schoolName: String, creatorUid: String, studySubject: String, subcategorySubject: String, addressName: String, address: String, members: [String], completion: @escaping (_ success: Bool) -> Void) {
        
        let post = Post(date: date, postDescription: postDescription, postTitle: postTitle, creatorUid: creatorUid, schoolName: schoolName, studySubject: studySubject, subcategorySubject: subcategorySubject, addressName: addressName, address: address, members: members)
        
        postRef.child("Posts").childByAutoId().setValue(post.dictionaryRepresentaion)
        completion(true)
    }
    
    // Join a Post
    func joinPost(post: Post) {
        guard let currentStudent = StudentController.shared.currentStudent else {return}
        post.members.append(currentStudent.identifier)
    }
    
    // Fetch all the posts that Student has joined
    func fetchJoinedPosts(completion: @escaping() -> Void) {
    
    }
    
    // Fetches all the post created by Student
    func fetchStudentPosts(completion: @escaping() -> Void) {
        var fetchedStudentPosts: [Post] = []
        guard let currentStudent = StudentController.shared.currentStudent else { return }
        self.postRef.child("Posts").queryOrdered(byChild:"creatorUid").queryEqual(toValue: currentStudent.identifier).observeSingleEvent(of: .value, with: { (snapshot) in
            if let postsDictionary = snapshot.value as? [String:Any] {
                for postDictionary in postsDictionary {
                    guard let postDictionaryValue = postDictionary.value as? [String:Any],
                        let post = Post(postsDictionary: postDictionaryValue)
                        else { completion(); return }
                    fetchedStudentPosts.append(post)
                }
                self.studentPosts = fetchedStudentPosts
                completion()
            }
        })
    }
    
    // Fetches all Posts
    func fetchAllPosts(completion: @escaping() -> Void) {
        var fetchedPosts: [Post] = []
        self.postRef.child("Posts").observeSingleEvent(of: .value, with: { (snapshot) in
            if let postsDictionary = snapshot.value as? [String:Any] {
                for postDictionary in postsDictionary {
                    guard let postDictionaryValue = postDictionary.value as? [String:Any],
                        let post = Post(postsDictionary: postDictionaryValue)
                        else { completion(); return }
                    fetchedPosts.append(post)
                }
                self.allPosts = fetchedPosts
                completion()
            }
        })
    }
}
