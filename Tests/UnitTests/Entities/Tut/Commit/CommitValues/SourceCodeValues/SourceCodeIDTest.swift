@testable import App
import XCTest

final class SourceCodeIDTest: XCTestCase {

    func test_等価() {
        let uuid = UUID()
        XCTAssertTrue(SourceCodeID(value: uuid) == SourceCodeID(value: uuid))
    }
    
    func test_不等価() {
        XCTAssertFalse(SourceCodeID(value: UUID()) == SourceCodeID(value: UUID()))
    }
}
