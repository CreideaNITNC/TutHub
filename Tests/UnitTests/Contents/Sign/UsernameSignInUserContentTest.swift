@testable import App
import XCTVapor

final class UsernameSignInUserContentTest: XCTestCase {
    
    let content = UsernameSignInUserContent(
        name: "Bob",
        password: "password"
    )
    
    func test_ユーザー名の取得() throws {
        XCTAssertEqual(
            try Username("Bob"),
            try content.getUsername
        )
    }
}
