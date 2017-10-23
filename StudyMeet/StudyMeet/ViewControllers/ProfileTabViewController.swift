//
//  ProfileTabViewController.swift
//  StudyMeet
//
//  Created by Sergio Gamez on 10/20/17.
//  Copyright © 2017 Sergio Gamez. All rights reserved.
//

import UIKit

class ProfileTabViewController: UIViewController {

    @IBOutlet weak var profilePicImageView: UIImageView!
    @IBOutlet weak var studentName: UILabel!
    @IBOutlet weak var studentSchoolName: UILabel!
    @IBOutlet weak var studentBio: UITextView!
    @IBOutlet weak var studentPostsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        
        PostController.shared.fetchStudentPosts {
            DispatchQueue.main.async {
                self.studentPostsTableView.reloadData()
            }
        }
    }

    func updateViews() {
        if let student = StudentController.shared.currentStudent {
            studentName.text = "\(student.firstName) \(student.lastName)"
            studentSchoolName.text = student.schoolName
            studentBio.text = student.bio
            profilePicImageView.image = student.profilePic
            profilePicImageView.layer.cornerRadius = profilePicImageView.frame.height / 2
            profilePicImageView.layer.masksToBounds = true
            
        } else{
            print("Student did not set")
        }
    }
}

extension ProfileTabViewController: UITableViewDelegate, UITableViewDataSource {
   
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return profilePicImageView.frame.height * 0.5
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PostController.shared.studentPosts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.studentPostsTableView.dequeueReusableCell(withIdentifier: "studentPosts", for: indexPath) as? StudyPostTableViewCell else {return UITableViewCell()}
        
        let post = PostController.shared.studentPosts[indexPath.row]
        cell.updateViews(post: post)
        return cell
    }
 
}







