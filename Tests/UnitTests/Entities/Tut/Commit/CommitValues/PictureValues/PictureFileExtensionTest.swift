@testable import App
import XCTVapor

final class PictureFileExtensionTest: XCTestCase {
    
    func test_toString() throws {
        XCTAssertEqual(PictureFileExtension.apng.rawValue, "apng")
    }

}
