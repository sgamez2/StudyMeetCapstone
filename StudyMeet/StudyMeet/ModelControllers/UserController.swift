//
//  UserController.swift
//  StudyMeet
//
//  Created by Sergio Gamez on 10/9/17.
//  Copyright © 2017 Sergio Gamez. All rights reserved.
//

import Foundation

class UserController {
    
    static var users = [User]()
    
    private static let baseURL = URL(string: "https://studymeet-fc082.firebaseio.com/Users")
    
    static func newUser(with firstName: String, lastName: String,
                        bio: String, email: String, phoneNumber: Int, schoolName: String, userName: String,
                        completion: @escaping (_ succes: Bool) -> Void){
        
        let user = User(firstName: firstName, lastName: lastName, bio: bio, email: email, phoneNumber: phoneNumber, schoolName: schoolName, userName: userName)
        
        guard let unwrappedURL = baseURL else {fatalError("Broken URL")}
        
        let url = unwrappedURL.appendingPathComponent(user.identifier.uuidString).appendingPathComponent("json")
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.httpBody = user.jsonData
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, _, error) in
            var success = false
            
            defer {completion(success)}
            
            // Awesome Error handling
            if let error = error {
                print("Error Fetching dataTask \(error.localizedDescription)")
                completion(false)
                return
            }
            
            guard let data = data,
                let responseDataString = String(data: data, encoding: .utf8) else { return }
            
            if let error = error {
                print("Error with response \(error.localizedDescription)")
            } else {
                print("Successfully saved data to encoding. \nResponse: \(responseDataString)")
            }
            self.users.append(user)
            success = true
        }
        dataTask.resume()
    }
    
    static func fetchUsers(completion: @escaping () -> Void) {
        
        guard let url = baseURL?.appendingPathComponent("json") else {
            print("bad baseURL")
            completion(); return}
        
        let dataTask = URLSession.shared.dataTask(with: url) { (data, _, error) in

            guard let data = data else {
                print("No data returned from data task")
                completion(); return
            }
        
            guard let userDictionary = (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)) as? [String:[String:Any]] else {
                print("Fetching from JsonObject")
                completion(); return }
            
            let users = userDictionary.flatMap({ User(userDictionary: $0.value, identifier: $0.key )})
            self.users = users
            completion()
        }
        dataTask.resume()
    }
}
