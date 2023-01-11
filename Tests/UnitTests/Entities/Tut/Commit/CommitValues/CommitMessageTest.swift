@testable import App
import XCTest

final class CommitMessageTest: XCTestCase {

    func test_0文字() throws {
        let _ = try CommitMessage("")
    }
    
    func test_1万文字() throws {
        let _ = try CommitMessage(
            String(Array(repeating: "a", count: 10_000))
        )
    }
    
    func test_1万1文字() throws {
        XCTAssertThrowsError(try CommitMessage(
            String(Array(repeating: "a", count: 10_001))
        ))
    }
    
}
