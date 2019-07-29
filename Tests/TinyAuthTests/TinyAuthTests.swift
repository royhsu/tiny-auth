import XCTest
@testable import TinyAuth

final class TinyAuthTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(TinyAuth().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
