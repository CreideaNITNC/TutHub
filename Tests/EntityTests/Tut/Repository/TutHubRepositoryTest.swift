@testable import Entity
import XCTest

final class TutHubRepositoryTest: XCTestCase {

    func test_等価() throws {
        let id = RepositoryID(value: UUID())
        
        let repository1 = TutHubRepository(id: id)
        let repository2 = TutHubRepository(id: id)
        
        XCTAssertTrue(repository1 == repository2)
    }
    
    func test_不等価() throws {
        let repository1 = TutHubRepository(id: .init(value: UUID()))
        let repository2 = TutHubRepository(id: .init(value: UUID()))
        
        XCTAssertFalse(repository1 == repository2)
    }
}
