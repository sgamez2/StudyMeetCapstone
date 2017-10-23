//
//  SignUpViewController.swift
//  StudyMeet
//
//  Created by Sergio Gamez on 10/10/17.
//  Copyright © 2017 Sergio Gamez. All rights reserved.
//

import UIKit
import FirebaseDatabase

class SignUpViewController: UIViewController {
    
    var student: Student?
    
    
    // MARK: - IBOutlets
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var bioDescriptionTextView: UITextView!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var schoolNameTextField: UITextField!
    @IBOutlet weak var popUpView: UIView!
    
    // LifeCycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
        
        popUpView.layer.cornerRadius = 15
        
        bioDescriptionTextView.layer.cornerRadius = 15
        bioDescriptionTextView.layer.borderColor = UIColor.lightGray.cgColor
        bioDescriptionTextView.layer.borderWidth = 0.4
        profileImage.layer.cornerRadius = profileImage.frame.size.height / 2
        profileImage.layer.masksToBounds = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
    }
    
    // MARK: - IBActions
    @IBAction func signUpButtonTapped(_ sender: Any) {
        signUpClient()
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any){
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func imagePickerTapped(_ sender: Any){
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        
        let actionSheet = UIAlertController(title: "Choose profile \npicture.", message: nil, preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Camera Roll", style: .default, handler: { (action:UIAlertAction) in
            imagePickerController.sourceType = .photoLibrary
            imagePickerController.allowsEditing = true
            self.present(imagePickerController, animated: true, completion: nil)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Take Photo", style: .default, handler: { (action:UIAlertAction) in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                imagePickerController.sourceType = .camera
                self.present(imagePickerController, animated: true, completion: nil)
            } else {
                print("Camera not available")
            }
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: nil))
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    // MARK: - Helper Functions
    func signUpClient() {
        guard let firstName = firstNameTextField.text,
            let lastName = lastNameTextField.text,
            let bio = bioDescriptionTextView.text,
            let email = emailTextField.text,
            let password = passwordTextField.text,
            let schoolName = schoolNameTextField.text,
            let phoneNumber = phoneNumberTextField.text,
            let username = usernameTextField.text,
            let profilePic = profileImage.image,
            !firstName.isEmpty && !lastName.isEmpty && !username.isEmpty && !bio.isEmpty && !email.isEmpty
                && !schoolName.isEmpty else { errorAlert(); return }
        
        StudentController.shared.newStudentWith(firstName: firstName, lastName: lastName, bio: bio, email: email, password: password, phoneNumber: phoneNumber, schoolName: schoolName, userName: username, profilePic: profilePic, completion: { (success) in
            if success {
                self.successAlert()
            } else {
                self.errorAlert()
            }
        })
    }
    
    func successAlert(){
        let alert = UIAlertController(title: "Account setup successful!", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: { (action:UIAlertAction) in
            alert.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func errorAlert(){
        let alert = UIAlertController(title: "Please fill out all textfields", message: "Phone number is optional.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: { (action:UIAlertAction) in
            alert.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
}


// Image picker for Profile Picture
extension SignUpViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let editedimage = info[UIImagePickerControllerEditedImage] as? UIImage {
            profileImage.image = editedimage
        } else {
            let originalImage = info[UIImagePickerControllerOriginalImage] as? UIImage
            profileImage.image = originalImage
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

// Text Fields will no longer be covered by keyboard
extension SignUpViewController: UITextFieldDelegate, UITextViewDelegate {
    
    // Start Editing The Text Field
    func textFieldDidBeginEditing(_ textField: UITextField) {
        moveTextField(textField, moveDistance: -200, up: true)
    }
    
    // Finish Editing The Text Field
    func textFieldDidEndEditing(_ textField: UITextField) {
        moveTextField(textField, moveDistance: -200, up: false)
    }
    
    // Hide the keyboard when the return key pressed
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // Move the text field in a pretty animation!
    func moveTextField(_ textField: UITextField, moveDistance: Int, up: Bool) {
        let moveDuration = 0.3
        let movement: CGFloat = CGFloat(up ? moveDistance : -moveDistance)
        
        UIView.beginAnimations("animateTextField", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(moveDuration)
        self.view.frame = self.view.frame.offsetBy(dx: 0, dy: movement)
        UIView.commitAnimations()
    }
}

/*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destinationViewController.
 // Pass the selected object to the new view controller.
 }
 */
