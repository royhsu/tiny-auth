//
//  FeedTableViewController.swift
//  Examples
//
//  Created by Roy Hsu on 2019/8/22.
//

// MARK: - FeedTableViewController

import UIKit

final class FeedTableViewController: UITableViewController {
    
    var posts: [Post] = []
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        tableView.register(
            PostTableViewCell.self,
            forCellReuseIdentifier: String(describing: PostTableViewCell.self)
        )
        
    }
    
    override func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    )
    -> Int { return posts.count }
    
    override func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    )
    -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(
            withIdentifier: String(describing: PostTableViewCell.self),
            for: indexPath
        ) as! PostTableViewCell
        
        let post = posts[indexPath.row]
        
        cell.contentLabel.text = "\(post.createdDate)"
        
        return cell
        
    }
    
}
