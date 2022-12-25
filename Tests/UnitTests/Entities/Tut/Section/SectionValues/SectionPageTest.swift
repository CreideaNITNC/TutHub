@testable import App
import XCTVapor

final class SectionPageTest: XCTestCase {

    func test_不正値ページ0() throws {
        XCTAssertThrowsError(try SectionPage(0))
    }
    
    func test_ページ1() throws {
        let _ = try SectionPage(1)
    }
    
}
