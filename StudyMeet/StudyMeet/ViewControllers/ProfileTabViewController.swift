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

        // Do any additional setup after loading the view.
    }

    var student: Student? {
        didSet {
            updateViews()
        }
    }

    func updateViews() {
        if let student = StudentController.shared.currentStudent {
            studentName.text = "\(student.firstName) \(student.lastName)"
            studentSchoolName.text = student.schoolName
            studentBio.text = student.bio
            profilePicImageView.image = student.profilePic
        } else{
            print("Student did not set")
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

}
