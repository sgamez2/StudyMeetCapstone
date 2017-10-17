//
//  LoginViewController.swift
//  StudyMeet
//
//  Created by Sergio Gamez on 10/10/17.
//  Copyright © 2017 Sergio Gamez. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    // lifeCycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        do {
            try Auth.auth().signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    
    // MARK: - IBActions
    @IBAction func loginButtonTapped(_ sender: Any) {
        guard let username = usernameTextField.text,
            let password = passwordTextField.text,
            !username.isEmpty && !password.isEmpty else {self.errorAlert();return}
        
        StudentController.shared.loginStudent(email: username, password: password) { (success) in
            if success {
                self.performSegue(withIdentifier: "toMain", sender: self.loginButton)
            } else {
                self.errorAlert()
            }
        }
        
    }
    
    // Helper Methods
    func errorAlert() {
        let alert = UIAlertController(title: "Incorrect Email \nor Password", message: "Please try again", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: { (action:UIAlertAction) in
            alert.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
