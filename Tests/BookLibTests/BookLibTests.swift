import XCTest
@testable import BookLib

final class BookLibTests: XCTestCase {
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(BookLib().text, "Hello, World!")
    }
}
