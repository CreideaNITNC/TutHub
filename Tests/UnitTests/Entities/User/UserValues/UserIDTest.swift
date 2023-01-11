@testable import App
import XCTest

final class UserIDTest: XCTestCase {

    func test_等価() {
        let uuid = UUID()
        XCTAssertTrue(UserID(value: uuid) == UserID(value: uuid))
    }
    
    func test_不等価() {
        XCTAssertFalse(UserID(value: UUID()) == UserID(value: UUID()))
    }
}
