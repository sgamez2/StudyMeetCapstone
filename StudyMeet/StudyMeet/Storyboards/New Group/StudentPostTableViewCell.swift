//
//  StudentPostTableViewCell.swift
//  StudyMeet
//
//  Created by Sergio Gamez on 10/23/17.
//  Copyright © 2017 Sergio Gamez. All rights reserved.
//

import UIKit

class StudentPostTableViewCell: UITableViewCell {

    @IBOutlet weak var profilePicImageView: UIImageView!
    @IBOutlet weak var subcategorySubjectLabel: UILabel!
    @IBOutlet weak var genericSubjectLabel: UILabel!
    @IBOutlet weak var dateTimeLabel: UILabel!
    @IBOutlet weak var postDescriptionTextView: UITextView!
    
    func updateViews(_ post: Post, _ student: Student) {
        profilePicImageView.layer.cornerRadius = profilePicImageView.frame.height / 2
        profilePicImageView.layer.masksToBounds = true
        
        profilePicImageView.image = student.profilePic
        subcategorySubjectLabel.text = post.subcategorySubject
        genericSubjectLabel.text = post.studySubject
        dateTimeLabel.text = post.date
        postDescriptionTextView.text = post.postDescription
    }
    
}
