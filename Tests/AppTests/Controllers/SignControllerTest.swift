@testable import App
import XCTVapor

final class SignControllerTest: XCTestCase {
    
    var app: Application = Application(.testing)
    
    override func setUp() async throws {
        app = Application(.testing)
        try configure(app)
        try await app.seedersSeed()
    }
    
    override func tearDown() async throws {
        try await app.seedersRevert()
        app.shutdown()
    }
    
    func test_既存のユーザーでSingIn() throws {
        try app.test(.POST, "sign/in") { req in
            try req.content.encode([
                "mailAddress": "tanaka@icloud.com",
                "password": "456@tanaka"
            ])
        } afterResponse: { res in
            XCTAssertEqual(res.status, .ok)
            XCTAssertContains(res.body.string, "TutHub Home")
        }
    }
    
    func test_既存のユーザーでSingIn失敗() throws {
        try app.test(.POST, "sign/in") { req in
            try req.content.encode([
                "mailAddress": "tanaka@icloud.com",
                "password": "123@tanaka"
            ])
        } afterResponse: { res in
            XCTAssertEqual(res.status, .ok)
            XCTAssertContains(res.body.string, "メールアドレス、またはパスワードが違います。")
        }
    }
    
    func test_新規のユーザーを作成してSignIn() throws {
        try app.test(.POST, "sign/up") { req in
            try req.content.encode([
                "mailAddress": "imanishi@outlook.com",
                "password": "012@imanishi"
            ])
        } afterResponse: { res in
            XCTAssertEqual(res.status, .ok)
            XCTAssertContains(res.body.string, "TutHub Home")
            
            try app.test(.POST, "sign/in") { req in
                try req.content.encode([
                    "mailAddress": "imanishi@outlook.com",
                    "password": "012@imanishi"
                ])
            } afterResponse: { res in
                XCTAssertEqual(res.status, .ok)
                XCTAssertContains(res.body.string, "TutHub Home")
            }
        }
    }
    
    func test_既に登録しているメールアドレスでSignUp() throws {
        try app.test(.POST, "sign/up") { req in
            try req.content.encode([
                "mailAddress": "tanaka@icloud.com",
                "password": "tanaka@0212"
            ])
        } afterResponse: { res in
            XCTAssertEqual(res.status, .ok)
            XCTAssertContains(res.body.string, "そのメールアドレスはすでに登録されています。")
            
            try app.test(.POST, "sign/in") { req in
                try req.content.encode([
                    "mailAddress": "tanaka@icloud.com",
                    "password": "tanaka@0212"
                ])
            } afterResponse: { res in
                XCTAssertEqual(res.status, .ok)
                XCTAssertContains(res.body.string, "メールアドレス、またはパスワードが違います。")
            }
        }
    }
}
