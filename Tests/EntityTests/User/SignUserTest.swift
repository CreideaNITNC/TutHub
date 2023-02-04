@testable import Entity
import XCTest

final class SignUserTest: XCTestCase {

    func test_等価() throws {
        let id = UserID(value: UUID())
        
        let user1 = try SignUser(
            id: id,
            username: .init("name"),
            mailAddress: .init("test@example.com"),
            passwordHash: .init(value: "password hash")
        )
        let user2 = try SignUser(
            id: id,
            username: .init("name"),
            mailAddress: .init("test@example.com"),
            passwordHash: .init(value: "password hash")
        )
        
        XCTAssertTrue(user1 == user2)
    }
    
    func test_不等価() throws {
        
        let user1 = try SignUser(
            id: .init(value: UUID()),
            username: .init("name"),
            mailAddress: .init("test@example.com"),
            passwordHash: .init(value: "password hash")
        )
        let user2 = try SignUser(
            id: .init(value: UUID()),
            username: .init("name"),
            mailAddress: .init("test@example.com"),
            passwordHash: .init(value: "password hash")
        )
        
        XCTAssertFalse(user1 == user2)
    }
    
    func test_ユーザの取り出し() throws {
        let id = UserID(value: UUID())
        
        let user = try SignUser(
            id: id,
            username: .init("name"),
            mailAddress: .init("test@example.com"),
            passwordHash: .init(value: "password hash")
        )
        
        XCTAssertEqual(user.user, User(id: id))
    }
}
