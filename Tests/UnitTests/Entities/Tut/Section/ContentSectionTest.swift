@testable import App
import XCTest

final class ContentSectionTest: XCTestCase {

    func test_等価() throws {
        let id = SectionID(value: UUID())
        
        let section1 = try ContentSection(id: id, title: .init("Hello"), commits: [])
        let section2 = try ContentSection(id: id, title: .init("Hello"), commits: [])
        
        XCTAssertTrue(section1 == section2)
    }
    
    func test_不等価() throws {
        let section1 = try ContentSection(id: .init(value: UUID()), title: .init("Hello"), commits: [])
        let section2 = try ContentSection(id: .init(value: UUID()), title: .init("Hello"), commits: [])
        
        XCTAssertFalse(section1 == section2)
    }
}
