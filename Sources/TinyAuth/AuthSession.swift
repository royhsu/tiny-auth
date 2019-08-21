// MARK: - AuthSession

import TinyKeyValueStore

/// AuthSession provides a common layer to communicate auth providers with the connected store.
public final class AuthSession<Auth> {
    
    public var auth: Auth? { return authField.wrappedValue }
    
    private let authField: Field<String, Auth>
    
    private var authTask: AuthTask?
    
    public init(authField: Field<String, Auth>) { self.authField = authField }
    
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
        completion: @escaping (Result<Auth?, Error>) -> Void
    ) {
        
        precondition(authTask == nil)
        
        authTask = provider { result in
            
            self.authTask = nil
            
            do {
                
                self.authField.wrappedValue = try result.get()
                
                completion(.success(self.auth))
                
            }
            catch { completion(.failure(error)) }
            
        }
        
    }
    
}
