//
//  AddPostViewController.swift
//  StudyMeet
//
//  Created by Sergio Gamez on 10/12/17.
//  Copyright © 2017 Sergio Gamez. All rights reserved.
//

import UIKit
import GooglePlacePicker

class AddPostViewController: UIViewController, GMSPlacePickerViewControllerDelegate, UITextFieldDelegate {
    
    // Properties
    let subjectsPicker = UIPickerView()
    let postButton = UIBarButtonItem()
    
    // MARK: - IBOutlets
    @IBOutlet weak var genericSubjectTextField: UITextField!
    @IBOutlet weak var subjectSubcategoryTextField: UITextField!
    @IBOutlet weak var postDescriptionTextView: UITextView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var meetAddressTextView: UITextView!
    @IBOutlet weak var placeNameLabel: UILabel!
    @IBOutlet weak var dateTextField: UITextField!
    
    // MARK: - LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
        placeNameLabel.isHidden = true
        postDescriptionTextView.layer.cornerRadius = 15
        meetAddressTextView.layer.cornerRadius = 10
        dateTextField.inputView = datePicker
        subjectPicker()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    // MARK: - @IBActions
    @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
        sender.minimumDate = Date()
        self.dateTextField.text = sender.date.stringValue()
    }
    
    @IBAction func choseAPlaceButtonTapped(_ sender: Any) {
        let config = GMSPlacePickerConfig(viewport: nil)
        let placePicker = GMSPlacePickerViewController(config: config)
        placePicker.delegate = self
        
        present(placePicker, animated: true, completion: nil)
    }
    
    @IBAction func userTappedView(_ sender: Any) {
        self.dateTextField.resignFirstResponder()
        self.genericSubjectTextField.resignFirstResponder()
        self.subjectSubcategoryTextField.resignFirstResponder()
        self.postDescriptionTextView.resignFirstResponder()
        self.resignFirstResponder()
    }
    
    @IBAction func postButtonTapped(_ sender: Any) {
        addPost()
    }
    
    // MARK: - Helper Methods
    func subjectPicker() {
        genericSubjectTextField.inputView = subjectsPicker
        subjectsPicker.delegate = self
        subjectsPicker.dataSource = self 
    }
    
    // Create post
    func addPost(){
        guard let genericSubject = genericSubjectTextField.text,
            let subcategorySubject = subjectSubcategoryTextField.text,
            let postDescription = postDescriptionTextView.text,
            let date = dateTextField.text,
            let address = meetAddressTextView.text,
            let addressName = placeNameLabel.text,
            let student = StudentController.shared.currentStudent,
            !genericSubject.isEmpty && !subcategorySubject.isEmpty && !postDescription.isEmpty && !date.isEmpty && !address.isEmpty
            else { missingFieldsAlert(); return }
        
        PostController.shared.newPost(with: date, postDescription: postDescription, postTitle: subcategorySubject, schoolName: student.schoolName, creatorUid: student.identifier, studySubject: genericSubject, subcategorySubject: subcategorySubject, addressName: addressName, address: address, members:[student.identifier]) { (success) in
            if success {
                self.successAlert()
            } else {
                print("Error with posting")
            }
        }
    }
    
    func missingFieldsAlert(){
        let alert = UIAlertController(title: "Missing text fields", message: "Please fill out all fields.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Got it!", style: .default, handler: { (action:UIAlertAction) in
            alert.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func successAlert(){
        let alert = UIAlertController(title: "Post succefully created!", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: { (action:UIAlertAction) in
            self.navigationController?.popViewController(animated: true)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    // Google Place Picker helper
    func placePicker(_ viewController: GMSPlacePickerViewController, didPick place: GMSPlace) {
        viewController.dismiss(animated: true, completion: nil)
        viewController.accessibilityActivate()
        placeNameLabel.text = "\(place.name)"
        meetAddressTextView.text = "Address: \n\(place.formattedAddress ?? "")"
        
        if meetAddressTextView.text.isEmpty {
            meetAddressTextView.isHidden = true
        } else {
            meetAddressTextView.isHidden = false
            placeNameLabel.isHidden = false
        }
        print("attributions: \(String(describing: place.attributions ))")
        print("\(String(describing: place.formattedAddress))")
    }
    
    func placePickerDidCancel(_ viewController: GMSPlacePickerViewController) {
        viewController.dismiss(animated: true, completion: nil)
        print("No Place Selected")
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
extension AddPostViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return HelperMethods.shared.genericSubjectsArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return HelperMethods.shared.genericSubjectsArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        genericSubjectTextField.text = HelperMethods.shared.genericSubjectsArray[row]
    }
}
