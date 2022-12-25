@testable import App
import XCTVapor

final class PictureDataTest: XCTestCase {

    func test_正常() throws {
        let _ = try PictureData(Data(repeating: 0, count: 100))
    }
    
    func test_10MB() throws {
        let _ = try PictureData(Data(repeating: 0, count: 10_000_000))
    }
    
    func test_不正値10MB超え() throws {
        XCTAssertThrowsError(try PictureData(Data(repeating: 0, count: 10_000_001)))
    }
}
