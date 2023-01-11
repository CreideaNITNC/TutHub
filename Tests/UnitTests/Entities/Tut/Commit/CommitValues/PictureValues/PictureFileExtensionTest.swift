@testable import App
import XCTest

final class PictureFileExtensionTest: XCTestCase {
    
    func test_toString() throws {
        XCTAssertEqual(PictureFileExtension.apng.rawValue, "apng")
    }
    
}
