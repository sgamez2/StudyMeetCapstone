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
    
    
    // MARK: - IBOutlets
    @IBOutlet weak var genericSubjectTextField: UITextField!
    @IBOutlet weak var subjectSubcategoryTextField: UITextField!
    @IBOutlet weak var postDescriptionTextView: UITextView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var meetAddressTextView: UITextView!
    @IBOutlet weak var placeNameLabel: UILabel!
    
    // MARK: - LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        placeNameLabel.isHidden = true
        postDescriptionTextView.layer.cornerRadius = 15
        meetAddressTextView.layer.cornerRadius = 10
        
    }    
    
    // MARK: - @IBActions
    @IBAction func datePickerValueChanged(_ sender: Any) {
    }
    
    @IBAction func choseAPlaceButtonTapped(_ sender: Any) {
        let config = GMSPlacePickerConfig(viewport: nil)
        let placePicker = GMSPlacePickerViewController(config: config)
        placePicker.delegate = self
        
        present(placePicker, animated: true, completion: nil)
    }
    
    // MARK: - Helper Methods
    
    // Google Place Picker helper
    func placePicker(_ viewController: GMSPlacePickerViewController, didPick place: GMSPlace) {
        viewController.dismiss(animated: true, completion: nil)
        placeNameLabel.text = "Place name: \(place.name)"
        meetAddressTextView.text = "Address: \(place.formattedAddress ?? "")"
        
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
