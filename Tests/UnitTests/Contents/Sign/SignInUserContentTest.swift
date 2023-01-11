@testable import App
import Entity
import XCTest

final class SignInUserContentTest: XCTestCase {
    
    func test_メールアドレスの取得() throws {
        let content = MailAddressSignInUserContent(
            mail: "test@example.com",
            password: "password"
        )
        
        XCTAssertEqual(
            try MailAddress("test@example.com"),
            try content.getMailAddress
        )
    }
    
}
