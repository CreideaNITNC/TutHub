@testable import App
import XCTest

final class PictureIDTest: XCTestCase {

    func test_等価() {
        let uuid = UUID()
        XCTAssertTrue(PictureID(value: uuid) == PictureID(value: uuid))
    }
    
    func test_不等価() {
        XCTAssertFalse(PictureID(value: UUID()) == PictureID(value: UUID()))
    }
}
