//
//  PostListViewController.swift
//  StudyMeet
//
//  Created by Sergio Gamez on 10/9/17.
//  Copyright © 2017 Sergio Gamez. All rights reserved.
//

import UIKit

class PostListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
  
    @IBOutlet var postTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.postTableView.reloadData()
    }
   
    // MARK: - Helper Methods
    // Search Bar
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchSubject = searchBar.text else {return}
        PostController.shared.fetchPosts(by: searchSubject)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PostController.shared.posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.postTableView.dequeueReusableCell(withIdentifier: "studyPostCell", for: indexPath) as? StudyPostTableViewCell else {return UITableViewCell()}
        
        let post = PostController.shared.posts[indexPath.row]
        cell.updateViews(post: post)
        return cell
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
