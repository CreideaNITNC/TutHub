@testable import Entity
import XCTest

final class PictureFilenameTest: XCTestCase {
    
    func test_等価() throws {
        XCTAssertTrue(try PictureFilename("hello") == (try PictureFilename("hello")))
        XCTAssertFalse(try PictureFilename("hello") == (try PictureFilename("hell")))
    }

    func test_PATH付きの不正値() throws {
        XCTAssertThrowsError(try PictureFilename("user/picture"))
    }
    
    func test_空文字の不正値() throws {
        XCTAssertThrowsError(try PictureFilename(""))
    }
    
    func test_1文字のファイル名() throws {
        let _ = try PictureFilename("a")
    }
    
    func test_100文字のファイル名() throws {
        let _ = try PictureFilename(String(Array(repeating: "a", count: 100)))
    }
    
    func test_不正値101文字のファイル名() throws {
        XCTAssertThrowsError(try PictureFilename(String(Array(repeating: "a", count: 101))))
    }

}
