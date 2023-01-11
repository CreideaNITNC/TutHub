@testable import App
import XCTest

final class UsernameTest: XCTestCase {

    func test_1文字() throws {
        let _ = try Username("a")
    }
    
    func test_不正値0文字() throws {
        XCTAssertThrowsError(try Username(""))
    }
    
    func test_不正値空白つき() throws {
        XCTAssertThrowsError(try Username("hello world"))
    }
    
    func test_不正値スラッシュ付き() throws {
        XCTAssertThrowsError(try Username("hello/world"))
    }
    
    func test_大文字小文字ハイフン英数字() throws {
        let _ = try Username("Hello-World0189")
    }
    
    func test_不正値アンダースコア() throws {
        XCTAssertThrowsError(try Username("Hello_World"))
    }
    
    func test_不正値日本語() throws {
        XCTAssertThrowsError(try Username("こんにちは"))
    }
}
