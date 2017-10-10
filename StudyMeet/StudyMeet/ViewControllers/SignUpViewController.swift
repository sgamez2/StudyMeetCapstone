//
//  SignUpViewController.swift
//  StudyMeet
//
//  Created by Sergio Gamez on 10/10/17.
//  Copyright © 2017 Sergio Gamez. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var bioDescriptionTextView: UITextView!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var schoolNameTextField: UITextField!
    @IBOutlet weak var popUpView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        popUpView.layer.cornerRadius = 15
        profileImage.layer.cornerRadius = profileImage.frame.height / 2
        bioDescriptionTextView.layer.cornerRadius = 15
        bioDescriptionTextView.layer.borderColor = UIColor.lightGray.cgColor
        bioDescriptionTextView.layer.borderWidth = 0.4
    }

    // MARK: - IBActions
    @IBAction func signUpButtonTapped(_ sender: Any) {
    }
    @IBAction func cancelButtonTapped(_ sender: Any){
        
    }
    @IBAction func imagePickerTapped(_ sender: Any){
        
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
