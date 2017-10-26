//
//  JoinedPostsTableViewController.swift
//  StudyMeet
//
//  Created by Sergio Gamez on 10/25/17.
//  Copyright © 2017 Sergio Gamez. All rights reserved.
//

import UIKit

class JoinedPostsTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return PostController.shared.joinedPosts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "joinedPostCell", for: indexPath) as? JoinedPostsTableViewCell else {return UITableViewCell()}
        
        
        
        return cell
    }
 
    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

}
