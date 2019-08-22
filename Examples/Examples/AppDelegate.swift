//
//  AppDelegate.swift
//  Examples
//
//  Created by Roy Hsu on 2019/8/21.
//  Copyright © 2019 TinyWorld. All rights reserved.
//

// MARK: - AppDelegate

import TinyAuth
import TinyKeyValueStore
import UIKit

@UIApplicationMain
public final class AppDelegate: UIResponder {
    
    public final let window = UIWindow(frame: UIScreen.main.bounds)
    
    private let authSession = AuthSession<Auth>(
        authField: Field(name: "auth", store: Memory())
    )
    
}

// MARK: - UIApplicationDelegate

extension AppDelegate: UIApplicationDelegate {
    
    public final func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    )
    -> Bool {
        
        window.rootViewController = UINavigationController(
            rootViewController: FeedViewController(authSession: authSession)
        )
        
        window.makeKeyAndVisible()
        
        return true
            
    }
    
}
