// MARK: - AuthSessionTests

import TinyKeyValueStore
import XCTest

@testable import TinyAuth

final class AuthSessionTests: XCTestCase {
   
    func testInitialize() {
        
        let memory: Memory<String, Auth> = [ "auth": Auth(user: .init(id: 1)) ]

        let session = AuthSession(
            authField: Field(name: "auth", store: memory)
        )

        XCTAssertEqual(session.auth, Auth(user: .init(id: 1)))
        
    }
    
    func testAuthorize() {

        let authorizeDidComplete = expectation(description: "Authorize did complete.")

        let mockAuthProvider: AuthProvider<Auth, Error> = { completion in

            DispatchQueue.global().async {

                completion(.success(Auth(user: .init(id: 1))))

            }

            return MockAuthTask()

        }

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
    
    static var allTests = [
        ("testInitialize", testInitialize),
        ("testAuthorize", testAuthorize),
    ]
    
}
