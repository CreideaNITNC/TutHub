@testable import App
import XCTVapor

final class MailAddressTest: XCTestCase {

    func test_正常値() throws {
        XCTAssertThrowsError(try MailAddress("test@example.com"))
    }
    
    func test_不正値1文字() throws {
        XCTAssertThrowsError(try MailAddress("a"))
    }
    
    func test_不正値アットマークなし文字() throws {
        XCTAssertThrowsError(try MailAddress("testexample.com"))
    }
    
}
