@testable import Entity
import XCTest

final class TutHubSettingRepositoryTest: XCTestCase {

    func test_等価() throws {
        let id = RepositoryID(value: UUID())
        
        let repository1 = try TutHubSettingRepository(
            id: id,
            name: .init("name"),
            title: .init("title")
        )
        let repository2 = try TutHubSettingRepository(
            id: id,
            name: .init("name"),
            title: .init("title")
        )
        
        XCTAssertTrue(repository1 == repository2)
    }
    
    func test_不等価() throws {
        let repository1 = try TutHubSettingRepository(
            id: .init(value: UUID()),
            name: .init("name"),
            title: .init("title")
        )
        let repository2 = try TutHubSettingRepository(
            id: .init(value: UUID()),
            name: .init("name"),
            title: .init("title")
        )
        
        XCTAssertFalse(repository1 == repository2)
    }
}
