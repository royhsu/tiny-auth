// MARK: - TimeEffectiveTests

import XCTest

final class TimeEffectiveTests: XCTestCase {
    
    func testIsExpired() {
        
        let unlimitedAuth = Auth(user: .init(id: 1))
        
        XCTAssertFalse(unlimitedAuth.isExpired)
        
        let unexpiredAuth = Auth(
            user: .init(id: 1),
            expirationDate: Calendar.current.date(
                byAdding: .day,
                value: 5,
                to: Date()
            )
        )
        
        XCTAssertFalse(unexpiredAuth.isExpired)
        
        let expiredAuth = Auth(
            user: .init(id: 1),
            expirationDate: Calendar.current.date(
                byAdding: .day,
                value: -5,
                to: Date()
            )
        )
        
        XCTAssert(expiredAuth.isExpired)
        
    }
    
    static var allTests = [
        ("testIsExpired", testIsExpired)
    ]
    
}
