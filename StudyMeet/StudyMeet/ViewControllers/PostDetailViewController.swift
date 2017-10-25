//
//  PostDetailViewController.swift
//  StudyMeet
//
//  Created by Sergio Gamez on 10/25/17.
//  Copyright © 2017 Sergio Gamez. All rights reserved.
//

import UIKit

class PostDetailViewController: UIViewController {
    
    var post: Post?

    @IBOutlet weak var profilePicImage: UIImageView!
    @IBOutlet weak var subcategoryLabel: UILabel!
    @IBOutlet weak var genericLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var postDescriptionView: UITextView!
    @IBOutlet weak var adressNameLabel: UILabel!
    @IBOutlet weak var adressTextView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    @IBAction func joinButtonTapped(_ sender: Any) {
        guard let post = self.post else {print("members did not join"); return}
        
    }
    
    func updateViews() {
        guard let post = self.post else {print("PostDetailVC post != self.post");return}
        profilePicImage.layer.cornerRadius = profilePicImage.frame.height / 2
        profilePicImage.layer.masksToBounds = true
        
        StudentController.shared.fetchImageFromFIRStorage(post.creatorUid) { (image) in
            self.profilePicImage.image = image
        }
        
        subcategoryLabel.text = post.subcategorySubject
        genericLabel.text = post.studySubject
        postDescriptionView.text = post.postDescription
        adressNameLabel.text = post.addressName
        adressTextView.text = post.address
    }
    
    
}
