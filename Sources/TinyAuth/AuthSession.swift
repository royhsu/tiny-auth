// MARK: - AuthSession

import Foundation
import TinyKeyValueStore

/// AuthSession provides a common layer to communicate auth providers with the connected store.
///
/// - Note: The current implementation only triggers .authDidChange notification from an AuthSession.
public final class AuthSession<Auth> {
    
    public var auth: Auth? { return authField.wrappedValue }
    
    private let authField: Field<String, Auth>
    
    private var authTask: AuthTask?
    
    private let notificationCenter: NotificationCenter
    
    public init(
        notificationCenter: NotificationCenter = .default,
        authField: Field<String, Auth>
    ) {
        
        self.notificationCenter = notificationCenter
        
        self.authField = authField
        
    }
    
}

extension AuthSession {
    
    /// To get authorized or revoke the existing auth.
    /// - Parameter provider: The auth provider.
    /// - Parameter completion: The result of the auth request.
    ///
    /// - Note: **DO NOT** start a new authorize before the previous one completes, otherwise,
    ///  the session will crash the program.
    public func authorize(
        with provider: AuthProvider<Auth, Error>,
        completion: ((Result<Auth, Error>) -> Void)? = nil
    ) {
        
        precondition(authTask == nil)
        
        authTask = provider { result in
            
            self.authTask = nil
            
            do {
                
                let auth = try result.get()
                
                self.authField.wrappedValue = auth
                
                self.notificationCenter.post(
                    name: .authDidChange,
                    object: self
                )
                
                completion?(.success(auth))
                
            }
            catch { completion?(.failure(error)) }
            
        }
        
    }
    
}

// MARK: - Notification

extension Notification.Name {
    
    public static let authDidChange = Notification.Name(rawValue: "authDidChange")
    
}
