@testable import Entity
import XCTest

final class TutHubContentRepositoryTest: XCTestCase {

    func test_等価() throws {
        let id = RepositoryID(value: UUID())
        
        let repository1 = TutHubContentRepository(id: id, sections: [])
        let repository2 = TutHubContentRepository(id: id, sections: [])
        
        XCTAssertTrue(repository1 == repository2)
    }
    
    func test_不等価() throws {
        let repository1 = TutHubContentRepository(id: .init(value: UUID()), sections: [])
        let repository2 = TutHubContentRepository(id: .init(value: UUID()), sections: [])
        
        XCTAssertFalse(repository1 == repository2)
    }
}
