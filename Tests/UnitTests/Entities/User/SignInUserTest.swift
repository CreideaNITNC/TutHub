@testable import App
import XCTVapor

final class SignInUserTest: XCTestCase {

    func test_等価() throws {
        let id = UserID(value: UUID())
        
        let user1 = try SignInUser(
            id: id,
            username: .init("name"),
            passwordHash: .init(value: "password hash")
        )
        let user2 = try SignInUser(
            id: id,
            username: .init("name"),
            passwordHash: .init(value: "password hash")
        )
        
        XCTAssertTrue(user1 == user2)
    }
    
    func test_不等価() throws {
        
        let user1 = try SignInUser(
            id: .init(value: UUID()),
            username: .init("name"),
            passwordHash: .init(value: "password hash")
        )
        let user2 = try SignInUser(
            id: .init(value: UUID()),
            username: .init("name"),
            passwordHash: .init(value: "password hash")
        )
        
        XCTAssertFalse(user1 == user2)
    }
}
