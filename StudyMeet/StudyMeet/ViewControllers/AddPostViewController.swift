//
//  AddPostViewController.swift
//  StudyMeet
//
//  Created by Sergio Gamez on 10/12/17.
//  Copyright © 2017 Sergio Gamez. All rights reserved.
//

import UIKit
import GooglePlacePicker

class AddPostViewController: UIViewController, GMSPlacePickerViewControllerDelegate {
    
    // Properties
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
        
    }
    
    // MARK: - Helper Methods
    
    // Google Place Picker helper
    func placePicker(_ viewController: GMSPlacePickerViewController, didPick place: GMSPlace) {
        viewController.dismiss(animated: true, completion: nil)
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
