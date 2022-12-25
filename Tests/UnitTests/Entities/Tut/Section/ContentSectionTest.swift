@testable import App
import XCTVapor

final class ContentSectionTest: XCTestCase {

    func test_等価() throws {
        let id = SectionID(value: UUID())
        
        let section1 = ContentSection(id: id, commits: [])
        let section2 = ContentSection(id: id, commits: [])
        
        XCTAssertTrue(section1 == section2)
    }
    
    func test_不等価() throws {
        let section1 = ContentSection(id: .init(value: UUID()), commits: [])
        let section2 = ContentSection(id: .init(value: UUID()), commits: [])
        
        XCTAssertFalse(section1 == section2)
    }
}
