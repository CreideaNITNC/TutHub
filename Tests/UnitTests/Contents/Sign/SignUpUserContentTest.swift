@testable import App
import XCTest

final class SignUpUserContentTest: XCTestCase {
    
    let content = SignUpUserContent(
        mail: "test@example.com",
        name: "Bob",
        password: "password"
    )
    
    func test_メールアドレスの取得() throws {
        XCTAssertEqual(
            try MailAddress("test@example.com"),
            try content.getMailAddress
        )
    }
    
    func test_ユーザー名の取得() throws {
        XCTAssertEqual(
            try Username("Bob"),
            try content.getUsername
        )
    }
    
}
