//
//  FeedViewController.swift
//  Examples
//
//  Created by Roy Hsu on 2019/8/22.
//  Copyright © 2019 TinyWorld. All rights reserved.
//

// MARK: - FeedViewController

import TinyAuth
import UIKit

final class FeedViewController: UIViewController {
    
    let authSession: AuthSession<Auth>
    
    private lazy var feedTableViewController: FeedTableViewController = {
        
        let feedTableViewController = FeedTableViewController()
        
        feedTableViewController.posts = [ Post(), Post(), ]
        
        return feedTableViewController
        
    }()
    
    init(authSession: AuthSession<Auth>) {
        
        self.authSession = authSession
        
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
        
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addPost)
        )
        
        addChild(feedTableViewController)
        
        feedTableViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(feedTableViewController.view)
        
        NSLayoutConstraint.activate(
            [
                view.leadingAnchor.constraint(equalTo: feedTableViewController.view.leadingAnchor),
                view.topAnchor.constraint(equalTo: feedTableViewController.view.topAnchor),
                view.trailingAnchor.constraint(equalTo: feedTableViewController.view.trailingAnchor),
                view.bottomAnchor.constraint(equalTo: feedTableViewController.view.bottomAnchor),
            ]
        )
        
    }
    
}

extension FeedViewController {
    
    @objc
    func addPost(_ sender: UIBarButtonItem) {
        
        AuthPresentation(
            authSession: authSession,
            presentingViewController: self
        )
        .show { result in
            
            do {
                
                _ = try result.get()
                
                self.feedTableViewController.posts.append(Post())
                
                self.feedTableViewController.tableView.reloadData()
                
            }
            catch {
                
                DispatchQueue.main.async {
                    
                    let alertController = UIAlertController(
                        title: nil,
                        message: "\(error)",
                        preferredStyle: .alert
                    )
                    
                    alertController.addAction(
                        UIAlertAction(
                            title: "OK",
                            style: .cancel,
                            handler: nil
                        )
                    )
                    
                    self.present(
                        alertController,
                        animated: true,
                        completion: nil
                    )
                    
                }
                
            }
            
        }
        
    }
    
}
