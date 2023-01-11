@testable import App
import XCTest

final class UserPasswordHashTest: XCTestCase {

    func test_等価() {
        let hash1 = UserPasswordHash(value: "hello")
        let hash2 = UserPasswordHash(value: "hello")
        
        XCTAssertTrue(hash1 == hash2)
    }
    
    func test_不等価() {
        let hash1 = UserPasswordHash(value: "hello")
        let hash2 = UserPasswordHash(value: "world")
        
        XCTAssertFalse(hash1 == hash2)
    }
}
