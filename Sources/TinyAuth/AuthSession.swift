//
//  AuthSession.swift
//
//
//  Created by Roy Hsu on 2019/7/29.
//

// MARK: - AuthSession

final class AuthSession<Auth> {
    
    private(set) var auth: Auth?
    
    private var authTask: AuthTask?
    
}

extension AuthSession {
    
    /// To get authorized or revoke the existing auth.
    /// - Parameter provider: The auth provider.
    /// - Parameter completion: The result of the auth request.
    ///
    /// - Note: **DO NOT** start a new authorize before the previous one completes, otherwise,
    ///  the session will crash the program.
    func authorize(
        with provider: AuthProvider<Auth, Error>,
        completion: @escaping (Result<Auth?, Error>) -> Void
    ) {
        
        precondition(authTask == nil)
        
        authTask = provider { result in
            
            self.authTask = nil
            
            do {
                
                self.auth = try result.get()
                
                completion(.success(self.auth))
                
            }
            catch { completion(.failure(error)) }
            
        }
        
    }
    
}

// MARK: - AuthProvider

typealias AuthProvider<Auth, Failure> = (
    _ completion: @escaping (Result<Auth, Failure>) -> Void
)
-> AuthTask
where Failure: Error

// MARK: - AuthProvider

//protocol AuthProvider {
//
//    associatedtype Credentials
//
//    associatedtype Auth
//
//    associatedtype Failure: Error
//
//    func request(
//        with credentials: Credentials,
//        completion: @escaping (Result<Auth, Failure>) -> Void
//    )
//    -> AuthTask
//
//}

// MARK: - AnyAuthProvider

//struct AnyAuthProvider<Credentials, Auth, Failure> where Failure: Error {
//
//    private let _request: (
//        _ credentials: Credentials,
//        _ completion: @escaping (Result<Auth, Failure>) -> Void
//    )
//    -> AuthTask
//
//    init<P>(_ provider: P)
//    where
//        P: AuthProvider,
//        P.Credentials == Credentials,
//        P.Auth == Auth,
//        P.Failure == Failure { self._request = provider.request }
//
//}

// MARK: - AuthProvider

//extension AnyAuthProvider: AuthProvider {
//
//    func request(
//        with credentials: Credentials,
//        completion: @escaping (Result<Auth, Failure>) -> Void
//    )
//    -> AuthTask { _request(credentials, completion) }
//
//}
