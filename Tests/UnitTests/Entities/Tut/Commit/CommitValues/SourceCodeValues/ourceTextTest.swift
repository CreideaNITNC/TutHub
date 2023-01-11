@testable import App
import XCTest

final class SourceTextTest: XCTestCase {
    
    func test_0文字のソースコード() throws {
        let _ = try SourceText("")
    }
    
    func test_1万文字のソースコード() throws {
        let _ = try SourceText(String(Array(repeating: "a", count: 10_000)))
    }
    
    func test_1万1文字のソースコード() throws {
        XCTAssertThrowsError(try SourceText(String(Array(repeating: "a", count: 10_001))))
    }
}
