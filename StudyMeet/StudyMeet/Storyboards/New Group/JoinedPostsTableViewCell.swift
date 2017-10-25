//
//  JoinedPostsTableViewCell.swift
//  StudyMeet
//
//  Created by Sergio Gamez on 10/25/17.
//  Copyright © 2017 Sergio Gamez. All rights reserved.
//

import UIKit

class JoinedPostsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var subcategoryLabel: UILabel!
    @IBOutlet weak var genericSubjectLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var totalMembersLabel: UILabel!
    @IBOutlet weak var postDescriptionTextView: UITextView!
    @IBOutlet weak var profilePicImage: UIImageView!
    
    func updateViews(post: Post) {
        
        profilePicImage.layer.cornerRadius = profilePicImage.frame.height / 2
        profilePicImage.layer.masksToBounds = true
        
        StudentController.shared.fetchImageFromFIRStorage(post.creatorUid) { (image) in
            self.profilePicImage.image = image
        }
        
        subcategoryLabel.text = post.subcategorySubject
        genericSubjectLabel.text = post.studySubject
        dateLabel.text = post.date
        postDescriptionTextView.text = post.postDescription
        totalMembersLabel.text = "\(post.members.count) members"
    }
}
