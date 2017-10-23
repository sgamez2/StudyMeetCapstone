//
//  LaunchScreenCopyViewController.swift
//  StudyMeet
//
//  Created by Sergio Gamez on 10/23/17.
//  Copyright © 2017 Sergio Gamez. All rights reserved.
//

import UIKit
import Firebase

class LaunchScreenCopyViewController: UIViewController {
    
    //    override func viewDidLoad() {
    //        super.viewDidLoad()
    //        preformLaunchChecks()
    //    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        preformLaunchChecks()
    }
    
    fileprivate func preformLaunchChecks() {
        if Auth.auth().currentUser != nil {
            guard let currentUser = Auth.auth().currentUser else {return }
            let uid = currentUser.uid
            StudentController.shared.fetchCurrentStudentFromFIR(uid, completion: { (success) in
                if success {
                    let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                    guard let mainTabBarVC = storyBoard.instantiateViewController(withIdentifier: "tabBarController") as? UITabBarController else {return}
                    self.present(mainTabBarVC, animated: true, completion: nil)
                } else {
                    // FIXME
                    // Add Log out here
                }
            })
        } else {
            let storyBoard = UIStoryboard(name: "LoginScreen", bundle: nil)
            guard let loginVC = storyBoard.instantiateViewController(withIdentifier: "loginScreen") as? LoginViewController
                else {return}
            self.present(loginVC, animated: true, completion: nil)
            print("Dang you suck")
        }
    }
}
