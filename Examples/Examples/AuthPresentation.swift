//
//  AuthPresentation.swift
//  Examples
//
//  Created by Roy Hsu on 2019/8/22.
//  Copyright © 2019 TinyWorld. All rights reserved.
//

// MARK: - AuthPresentation

import TinyAuth
import UIKit

struct AuthPresentation {
    
    private let authSession: AuthSession<Auth>
    
    private let presentingViewController: UIViewController
    
    init(
        authSession: AuthSession<Auth>,
        presentingViewController: UIViewController
    ) {
        
        self.authSession = authSession
        
        self.presentingViewController = presentingViewController
        
    }
    
}

extension AuthPresentation {
    
    private func makeAuthViewController(
        completion: @escaping (Result<Auth, Error>) -> Void
    )
    -> UIViewController {
        
        let landingViewController = LandingViewController(authSession: authSession)
        
        landingViewController.authorizeDidComplete = { result in
            
            if let _ = self.presentingViewController.presentedViewController {
            
                self.presentingViewController.dismiss(
                    animated: true,
                    completion: nil
                )
                
            }
            
            completion(result)
            
        }
        
        return landingViewController
            
    }
    
    private func requestAuth(
        completion: @escaping (Result<Auth, Error>) -> Void
    ) {
        
        if let auth = authSession.auth {
            
            completion(.success(auth))
            
            return
            
        }
        
        let authViewController = makeAuthViewController(completion: completion)
        
        precondition(presentingViewController.presentedViewController == nil)
        
        presentingViewController.present(
            authViewController,
            animated: true,
            completion: nil
        )
        
    }
    
}

extension AuthPresentation {
    
    func show(_ completion: @escaping (Result<Auth, Error>) -> Void) {
        
        requestAuth(completion: completion)
        
    }
    
}
