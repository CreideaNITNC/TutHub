@testable import App
import XCTVapor

final class SectionIDTest: XCTestCase {

    func test_等価() {
        let uuid = UUID()
        XCTAssertTrue(SectionID(value: uuid) == SectionID(value: uuid))
    }
    
    func test_不等価() {
        XCTAssertFalse(SectionID(value: UUID()) == SectionID(value: UUID()))
    }
}
