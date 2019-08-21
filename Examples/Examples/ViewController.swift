//
//  ViewController.swift
//  Examples
//
//  Created by Roy Hsu on 2019/8/21.
//  Copyright © 2019 TinyWorld. All rights reserved.
//

// MARK: - ViewController

import TinyAuth
import TinyKeyValueStore
import UIKit

public final class ViewController: UIViewController {

    let authSession = AuthSession<Auth>(
        authField: Field(name: "auth", store: Memory())
    )
    
    // MARK: View Life Cycle

    public final override func viewDidLoad() {

        super.viewDidLoad()

        setUpRootView(view)
        
    }

    // MARK: Set Up

    fileprivate final func setUpRootView(_ view: UIView) {

        view.backgroundColor = .white
        
        let loginButton = UIButton(type: .system)
        
        loginButton.setTitle("Login", for: .normal)
        
        loginButton.addTarget(
            self,
            action: #selector(logIn),
            for: .touchUpInside
        )
        
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(loginButton)
        
        NSLayoutConstraint.activate(
            [
                view.centerXAnchor.constraint(equalTo: loginButton.centerXAnchor),
                view.centerYAnchor.constraint(equalTo: loginButton.centerYAnchor),
            ]
        )

    }
    
    @objc
    func logIn(_ sender: UIButton) {
        
        if let auth = authSession.auth { handleAuth(auth) }
        else {
            
            authSession.authorize(
                with: { completion in
                   
                    DispatchQueue.main.async {
                        
                        let mockLoginViewController = UIAlertController(
                            title: nil,
                            message: "Logging in...",
                            preferredStyle: .alert
                        )
                        
                        self.present(
                            mockLoginViewController,
                            animated: true,
                            completion: nil
                        )
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                        
                            completion(.success(Auth()))
                            
                            mockLoginViewController.dismiss(
                                animated: true,
                                completion: nil
                            )
                        
                        }
                        
                    }
                    
                    return MockAuthTask()
                    
                },
                completion: { result in
                
                    do {
                        
                        let auth = try result.get()
                        
                        self.handleAuth(auth)
                        
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
            )
        }
        
    }

    private func handleAuth(_ auth: Auth) {
        
        print("Authorzied: \(auth)")
        
    }
    
}

struct Auth { }

struct MockAuthTask: AuthTask {
    
    func cancel() { }
    
}
