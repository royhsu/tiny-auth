// MARK: - AuthSessionTests

import XCTest

@testable import TinyAuth

final class AuthSessionTests: XCTestCase {
   
    func testInitialize() {
        
        let session = AuthSession<Auth>()

        XCTAssertNil(session.auth)
        
    }
    
    func testAuthorize() {
        
        let authorizeDidComplete = expectation(description: "Authorize did complete.")
        
        let mockAuthProvider: AuthProvider<Auth, Error> = { completion in
            
            DispatchQueue.global().async {
                
                completion(.success(Auth(user: .init(id: 1))))
                
            }
            
            return MockAuthTask()
            
        }
        
        let session = AuthSession<Auth>()
        
        session.authorize(with: mockAuthProvider) { result in
            
            defer { authorizeDidComplete.fulfill() }
            
            do {
                
                let auth = try result.get()
                
                XCTAssertEqual(session.auth, auth)
            
                XCTAssertEqual(auth, Auth(user: .init(id: 1)))
                
            }
            catch { XCTFail("\(error)") }
                
        }
        
        waitForExpectations(timeout: 10.0)
        
    }
    
    static var allTests = [
        ("testInitialize", testInitialize),
        ("testAuthorize", testAuthorize),
    ]
    
}
