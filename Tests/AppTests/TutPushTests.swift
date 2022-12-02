@testable import App
import XCTVapor

final class TutPushTests: XCTestCase {
    
    var app: Application = Application(.testing)
    
    override func setUp() async throws {
        app = Application(.testing)
        try configure(app)
    }
    
    override func tearDown() {
        app.shutdown()
    }
    
    func testPush時にCreatedを返却する() throws {
        try app.test(.POST, "tanaka/vapor") { req in
            req.body = ByteBuffer(string: TEST_PUSH_JSON)
        } afterResponse: { res in
            XCTAssertEqual(res.status, .created)
        }
    }
    
    func testCI() throws {
        XCTAssertEqual("Hello", "World")
    }
}
