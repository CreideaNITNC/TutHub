@testable import App
import XCTVapor

final class CommitIDTest: XCTestCase {

    func test_等価() {
        let uuid = UUID()
        XCTAssertTrue(CommitID(value: uuid) == CommitID(value: uuid))
    }
    
    func test_不等価() {
        XCTAssertFalse(CommitID(value: UUID()) == CommitID(value: UUID()))
    }
}
