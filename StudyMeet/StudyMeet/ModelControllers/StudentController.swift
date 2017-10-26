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
    static let presentErrorAlertNotification = Notification.Name("present")
    
    func newStudentWith(firstName: String, lastName: String,
                        bio: String, email: String, password: String, phoneNumber: String, schoolName: String, profilePic: UIImage,
                        completion: @escaping (_ success: Bool) -> Void) {
        
        Auth.auth().createUser(withEmail: email, password: password) { (authenticatedUser, error) in
            if let error = error {
                
//                NotificationCenter.default.post(name: Notification.Name(rawValue: "present"), object: error)
                NotificationCenter.default.post(name: StudentController.presentErrorAlertNotification, object: nil, userInfo: ["error": error])
                
            } else {
                guard let authenticatedUser = authenticatedUser else  {return}
                
                let student = Student(firstName: firstName, lastName: lastName, bio: bio, email: email, password: password, phoneNumber: phoneNumber, schoolName: schoolName, profilePic: profilePic, identifier: authenticatedUser.uid)
                
                // save image
                self.currentStudent = student
                self.saveImageToFIRStorage(profileImage: profilePic)
                completion(true)
            }
        }
    }
    
    // Error Handling
    func handleError(_ error: Error) {
        if let errorCode = AuthErrorCode(rawValue: error._code) {
            let alert = UIAlertController(title: "\(errorCode.errorMessage)", message: "Please try again", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Got it!", style: .default, handler: nil))
            
            print(errorCode.errorMessage)
        }
    }
    
    func fetchCurrentStudentFromFIR(_ uid: String, completion: @escaping (Bool) -> Void) {
        baseRef.child("Students").child(uid).observeSingleEvent(of: .value) { (snapshot) in
            guard let studentDictionary = snapshot.value as? [String:Any],
                let studentProfilePicURL = studentDictionary["profilePicURL"] as? String
                else { print("Trouble getting current student."); completion(false); return }
            
            self.fetchImageFromFIRStorage(profilePicURL: studentProfilePicURL, completion: { (image) in
                if let image = image {
                    let student = Student(userDictionary: studentDictionary, image: image)
                    self.currentStudent = student
                    completion(true)
                }
            })
        }
    }
    
    func logoutStudent(_ completion: @escaping (Bool) -> Void) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            completion(true)
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
            completion(false)
        }
    }
    
    func updateStudent(student: Student, firstName: String, lastName: String,
                       bio: String, phoneNumber: String, schoolName: String, profilePic: UIImage) {
        
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
                        let studentProfilePicURL = studentDictionary["profilePicURL"] as? String
                        else {completion(false); return}
                    
                    self.fetchImageFromFIRStorage(profilePicURL: studentProfilePicURL, completion: { (image) in
                        if let image = image {
                            let student = Student(userDictionary: studentDictionary, image: image)
                            self.currentStudent = student
                            completion(true)
                            print("success")
                        }
                    })
                }
            }
        }
    }
    
    func saveImageToFIRStorage(profileImage: UIImage) {
        
        guard let currentStudent = self.currentStudent
            else { return }
        if let uploadData = UIImageJPEGRepresentation(currentStudent.profilePic, 1.0) {
            
            storageRef.child(currentStudent.identifier).putData(uploadData, metadata: nil, completion: { (metadata, error) in
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
    
    func fetchImageFromFIRStorage(_ studentUid: String, completion: @escaping(UIImage?) -> Void) {

//        guard let currentStudent = self.currentStudent else {return nil}

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
        
        Storage.storage().reference(withPath: studentUid).getData(maxSize: 6 * 1024 * 1024) { (data, error) in
            if let error = error {
                print(error.localizedDescription)
                completion(nil)
                return
            } else {
                guard let data = data else {return}
                let image = UIImage(data: data)
                completion(image)
            }
        }
    
    }
    
    func fetchImageFromFIRStorage(profilePicURL: String, completion: @escaping(UIImage?) -> Void){
        
        Storage.storage().reference(forURL: profilePicURL).getData(maxSize: 6 * 1024 * 1024) { (data, error) in
            if let error = error {
                print(error.localizedDescription)
                completion(nil)
                return
            } else {
                guard let data = data else {return}
                let image = UIImage(data: data)
                completion(image)
            }
        }
    }
}

extension AuthErrorCode {
    var errorMessage: String {
        switch self {
        case .emailAlreadyInUse:
            return "The email is already in use with another account"
        case .userDisabled:
            return "Your account has been disabled. Please contact support."
        case .invalidEmail, .invalidSender, .invalidRecipientEmail:
            return "Please enter a valid email"
        case .networkError:
            return "Network error. Please try again."
        case .weakPassword:
            return "Your password is too weak"
        default:
            return "Unknown error occurred, please try again!"
        }
    }
}








