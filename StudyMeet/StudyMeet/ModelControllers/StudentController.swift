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

class StudentController {
    
    static let shared = StudentController()
    let baseRef = Database.database().reference()
    var students = [Student]()
    var currentStudent: Student?
    
    func newStudentWith(firstName: String, lastName: String,
                     bio: String, email: String, password: String, phoneNumber: String, schoolName: String, userName: String,
                     //identifier: String,
                     completion: @escaping (_ success: Bool) -> Void) {
        
        Auth.auth().createUser(withEmail: email, password: password) { (authenticatedUser, error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                guard let authenticatedUser = authenticatedUser else  {return}
                let student = Student(firstName: firstName, lastName: lastName, bio: bio, email: email, password: password, phoneNumber: phoneNumber, schoolName: schoolName, userName: userName, identifier: authenticatedUser.uid)
                self.currentStudent = student
                self.baseRef.child("Students").child(student.identifier).setValue(student.dictionaryRepresention)
                completion(true)
            }
        }
    }
    
    func loginStudent(email: String, password: String, completion: @escaping(_ success: Bool) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { (authUser, error) in
            if let error = error {
                completion(false)
                print("\(error.localizedDescription)")
            } else {
                guard let authUser = authUser else { return }
                self.baseRef.child("Students").child(authUser.uid).observeSingleEvent(of: .value) { (snapshot) in
                    guard let studentDictionary = snapshot.value as? [String:Any] else {return}
                    let student = Student(userDictionary: studentDictionary)
                    self.currentStudent = student
                    completion(true)
                    print("success")
                }
            }
        }
    }
    
//    func fetchStudentFromDatabase(_ uid: String) -> Student? {
//
//
//    }
}

