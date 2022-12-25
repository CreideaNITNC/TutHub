@testable import App
import XCTVapor

final class SectionTitleTest: XCTestCase {

    func test_不正値0文字のセクションタイトル() throws {
        XCTAssertThrowsError(try SectionTitle(""))
    }
    
    func test_1文字のセクションタイトル() throws {
        let _ = try SectionTitle("a")
    }
    
    func test_20文字のセクションタイトル() throws {
        let _ = try SectionTitle(
            String(Array(repeating: "a", count: 20))
        )
    }
    
    func test_不正値21文字のセクションタイトル() throws {
        XCTAssertThrowsError(try SectionTitle(
            String(Array(repeating: "a", count: 21))
        ))
    }
    
}
