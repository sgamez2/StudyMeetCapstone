//
//  PostListViewController.swift
//  StudyMeet
//
//  Created by Sergio Gamez on 10/9/17.
//  Copyright © 2017 Sergio Gamez. All rights reserved.
//

import UIKit

class PostListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    // MARK: -  @IBOutlets
    @IBOutlet var postTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
        searchBar.delegate = self
    }
    
    // MARK: - Helper Methods
    // Search Bar
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchSubject = searchBar.text else {return}

//        PostController.shared.fetchPosts(by: searchSubject) {
//            DispatchQueue.main.async {
//                self.postTableView.reloadData()
//            }
//        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return PostController.shared.joinedPosts.count
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 120.0
//    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.postTableView.dequeueReusableCell(withIdentifier: "studyPostCell", for: indexPath) as? StudyPostTableViewCell else {return UITableViewCell()}
        
        let post = PostController.shared.joinedPosts[indexPath.row]
        
        if let student = StudentController.shared.currentStudent {
            cell.updateViews(post, student)
        } else {
            print("Could not set student in PostListVC")
        }
        return cell
    }
    
     // MARK: - Navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailView" {
            if let detailVC = segue.destination as? PostDetailViewController {
                if let indexPath = postTableView.indexPathForSelectedRow {
                    let post = PostController.shared.allPosts[indexPath.row]
                    detailVC.post = post
                }
            }
        }
     }
}

