// MARK: - AuthSessionTests

import TinyKeyValueStore
import XCTest

@testable import TinyAuth

final class AuthSessionTests: XCTestCase {
    
    let mockAuthProvider: AuthProvider<Auth, Error> = { completion in
        
        DispatchQueue.global().async {
            
            completion(.success(Auth(user: .init(id: 1))))
            
        }
        
        return MockAuthTask()
        
    }
    
    func testInitialize() {
        
        let memory: Memory<String, Auth> = [ "auth": Auth(user: .init(id: 1)) ]

        let session = AuthSession(
            authField: Field(name: "auth", store: memory)
        )

        XCTAssertEqual(session.auth, Auth(user: .init(id: 1)))
        
    }
    
    func testAuthorize() {

        let authorizeDidComplete = expectation(description: "Authorize did complete.")

        let session = AuthSession<Auth>(
            authField: Field(name: "auth", store: Memory())
        )

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
    
    func testAuthDidChangeNotification() {
        
        let authDidChange = expectation(description: "Did receive auth changes notifications.")
        
        let session = AuthSession<Auth>(
            authField: Field(name: "auth", store: Memory())
        )
        
        let observation = NotificationCenter.default.addObserver(
            forName: .authDidChange,
            object: session,
            queue: nil,
            using: { notification in
        
                defer { authDidChange.fulfill() }
                
                let sender = notification.object as? AuthSession<Auth>
                
                XCTAssertEqual(sender?.auth, Auth(user: .init(id: 1)))
                
            }
        )
        
        session.authorize(with: mockAuthProvider)
        
        waitForExpectations(timeout: 10.0)
        
    }
    
    static var allTests = [
        ("testInitialize", testInitialize),
        ("testAuthorize", testAuthorize),
        ("testAuthDidChangeNotification", testAuthDidChangeNotification),
    ]
    
}
