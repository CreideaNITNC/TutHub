@testable import App
import XCTest

final class OverviewSectionTest: XCTestCase {

    func test_等価() throws {
        let id = SectionID(value: UUID())
        
        let section1 = try OverviewSection(id: id, title: .init("hello"))
        let section2 = try OverviewSection(id: id, title: .init("hello"))
        
        XCTAssertTrue(section1 == section2)
    }
    
    func test_不等価() throws {
        let section1 = try OverviewSection(id: .init(value: UUID()), title: .init("hello"))
        let section2 = try OverviewSection(id: .init(value: UUID()), title: .init("hello"))
        
        XCTAssertFalse(section1 == section2)
    }
}
