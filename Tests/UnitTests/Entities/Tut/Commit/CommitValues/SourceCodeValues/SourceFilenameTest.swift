@testable import App
import XCTVapor

final class SourceFilenameTest: XCTestCase {
    
    func test_1文字のファイル名() throws {
        let _ = try SourceFilename("a")
    }
    
    func test_不正値0文字のファイル名() throws {
        XCTAssertThrowsError(try SourceFilename(""))
    }
    
    func test_100文字ののファイル名() throws {
        let _ = try SourceFilename(String(Array(repeating: "a", count: 100)))
    }
    
    func test_101文字ののファイル名() throws {
        XCTAssertThrowsError(try  SourceFilename(String(Array(repeating: "a", count: 101))))
    }
}
