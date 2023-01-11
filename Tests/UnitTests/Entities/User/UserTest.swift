@testable import App
import XCTest

final class UserTest: XCTestCase {

    func test_等価() {
        let id = UserID(value: UUID())
        XCTAssertTrue(User(id: id) == User(id: id))
    }
    
    func test_不等価() {
        XCTAssertFalse(User(id: .init(value: UUID())) == User(id: .init(value: UUID())))
    }
}
