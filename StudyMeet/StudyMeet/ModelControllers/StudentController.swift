//
//  StudentController.swift
//  StudyMeet
//
//  Created by Sergio Gamez on 10/9/17.
//  Copyright © 2017 Sergio Gamez. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth
import Firebase

class StudentController {
    
    static let shared = StudentController()
    let baseRef = Database.database().reference()
    let storageRef = Storage.storage().reference()
    var students = [Student]()
    var currentStudent: Student?
    
    func newStudentWith(firstName: String, lastName: String,
                        bio: String, email: String, password: String, phoneNumber: String, schoolName: String, userName: String, profilePic: UIImage,
                        completion: @escaping (_ success: Bool) -> Void) {
        
        Auth.auth().createUser(withEmail: email, password: password) { (authenticatedUser, error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                guard let authenticatedUser = authenticatedUser else  {return}
                
                let student = Student(firstName: firstName, lastName: lastName, bio: bio, email: email, password: password, phoneNumber: phoneNumber, schoolName: schoolName, userName: schoolName, profilePic: profilePic, identifier: authenticatedUser.uid)
                
                // save image
                self.saveImageToFIRStorage(profileImage: profilePic)
                self.currentStudent = student
//                self.baseRef.child("Students").child(student.identifier).setValue(student.dictionaryRepresention)
                completion(true)
            }
        }
    }
    
    func loginStudent(email: String, password: String, completion: @escaping(_ success: Bool) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { (authUser, error) in
            if let error = error {
                completion(false)
                print(error.localizedDescription)
            } else {
                guard let authUser = authUser else {completion(false); return }
                self.baseRef.child("Students").child(authUser.uid).observeSingleEvent(of: .value) { (snapshot) in
                    guard let studentDictionary = snapshot.value as? [String:Any],
                        let student = Student(userDictionary: studentDictionary)
                        else {completion(false); return}
                    
                    guard let fetchedImage = self.fetchImageFromFIRStorage(profilePicURL: student.profilePicURL) else {completion(false); return}
                    student.profilePic = fetchedImage
                    self.currentStudent = student
                    completion(true)
                    print("success")
                }
            }
        }
    }
    
    func saveImageToFIRStorage(profileImage: UIImage) { 
        
        guard let currentStudent = self.currentStudent else { return }
//        storageRef.child(currentStudent.identifier)
        if let uploadData = UIImagePNGRepresentation(currentStudent.profilePic) {
            
            storageRef.putData(uploadData, metadata: nil, completion: { (metadata, error) in
                if let error = error {
                    print(error.localizedDescription)
                    return
                } else {
                    guard let imageURL = metadata?.downloadURL()?.absoluteString else {return}
                    currentStudent.profilePicURL = imageURL
                    self.baseRef.child("Students").child(currentStudent.identifier).setValue(currentStudent.dictionaryRepresention)
                }
            })
        }
    }
    
//    func fetchImageFromFIRStorage(profilePicURL: String) -> UIImage? {
//
//        guard let currentStudent = self.currentStudent else {return nil}
//
//        Storage.storage().reference(forURL: profilePicURL).getData(maxSize: 5 * 1024 * 1024) { (data, error) in
//            if let error = error {
//                print(error.localizedDescription)
//                return nil
//            } else {
//                guard let data = data else {return}
//                let image = UIImage(data: data)
//                return image
//            }
//        }
//    }
    
    func fetchImageFromFIRStorage(profilePicURL: String) -> UIImage? {
        
        var imageToReturn: UIImage?
        
        Storage.storage().reference(forURL: profilePicURL).getData(maxSize: 5 * 1024 * 1024) { (data, error) in
            if let error = error {
                print(error.localizedDescription)
                imageToReturn = nil
                return
            } else {
                guard let data = data else {return}
                let image = UIImage(data: data)
                imageToReturn = image
            }
        }
        return imageToReturn
    }
}









