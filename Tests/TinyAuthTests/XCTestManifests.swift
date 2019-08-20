import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(TimeEffectiveTests.allTests),
        testCase(AuthSessionTests.allTests),
    ]
}
#endif
