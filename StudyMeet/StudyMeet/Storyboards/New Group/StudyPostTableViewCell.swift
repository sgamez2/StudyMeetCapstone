//
//  StudyPostTableViewCell.swift
//  StudyMeet
//
//  Created by Sergio Gamez on 10/18/17.
//  Copyright © 2017 Sergio Gamez. All rights reserved.
//

import UIKit

class StudyPostTableViewCell: UITableViewCell {

    // MARK: - IBOutlets
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var subcategorySubjectLabel: UILabel!
    @IBOutlet weak var genericSubjectLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    
    func updateViews(_ post: Post, _ student: Student) {
        profileImageView.layer.cornerRadius = profileImageView.frame.height / 2
        profileImageView.layer.masksToBounds = true
        
        profileImageView.image = student.profilePic
        subcategorySubjectLabel.text = post.subcategorySubject
        genericSubjectLabel.text = post.studySubject
        dateLabel.text = post.date
        descriptionTextView.text = post.postDescription
    }
    
}
