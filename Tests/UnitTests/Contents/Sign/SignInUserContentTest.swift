@testable import App
import XCTVapor

final class SignInUserContentTest: XCTestCase {
    
    func test_メールアドレスの取得() throws {
        let content = MailAddressSignInUserContent(
            mailAddress: "test@example.com",
            password: "password"
        )
        
        XCTAssertEqual(
            try MailAddress("test@example.com"),
            try content.getMailAddress()
        )
    }
    
}
