//
//  PostController.swift
//  StudyMeet
//
//  Created by Sergio Gamez on 10/10/17.
//  Copyright © 2017 Sergio Gamez. All rights reserved.
//

import Foundation

class PostController {
    
    static var posts = [Post]()
    
    private static let baseURL = URL(string: "https://studymeet-fc082.firebaseio.com/Posts")
    
    static func newPost(with date: Date, postDescription: String, postTitle: String, schoolName: String,
                        members: Int, completion: @escaping (_ success: Bool) -> Void) {
        
        let post = Post(date: date, postDescription: postDescription, postTitle: postTitle, schoolName: schoolName, members: members)
        
        guard let unwrappedURL = baseURL else {fatalError("BrokenURL")}
        
        let url = unwrappedURL.appendingPathComponent(UUID().uuidString).appendingPathComponent("json")
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.httpBody = post.jsonData
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, _, error) in
            var success = false
            
            defer {completion(success)}
            
            if let error = error {
                print("Error fetching dataTask \(error.localizedDescription)")
                completion(false); return
            }
            
            guard let data = data,
                let responseDataString = String(data: data, encoding: .utf8) else {return}
            if let error = error {
                print("Error with response \(error.localizedDescription)")
            } else {
                print("Successfully saved data to encoding. \nResponse: \(responseDataString)")
            }
            self.posts.append(post)
            success = true
        }
        dataTask.resume()
    }
    
    static func fetchPosts(completion: @escaping () -> Void) {
        
        guard let url = baseURL?.appendingPathComponent("json") else {
            print("badURL")
            completion(); return
        }
        
        let dataTask = URLSession.shared.dataTask(with: url) { (data, _, error) in
            
            guard let data = data else {
                print("No Data returned from DataTask")
                completion(); return
            }
            
            guard let postDictionary = (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)) as?
                [String:[String:Any]] else {
                    print("Fetching from JsonObject")
                    completion(); return }
                    
            let posts = postDictionary.flatMap({ Post(postsDictionary: $0.value )})
            self.posts = posts
            completion()
        }
        dataTask.resume()
    }
}








