@testable import App
import XCTest

final class SectionTest: XCTestCase {

    func test_等価() throws {
        let id = SectionID(value: UUID())
        
        let section1 = Section(id: id)
        
        let section2 = Section(id: id)
        
        XCTAssertTrue(section1 == section2)
    }
    
    func test_不等価() throws {
        let section1 = Section(id: .init(value: UUID()))
        
        let section2 = Section(id: .init(value: UUID()))
        
        XCTAssertFalse(section1 == section2)
    }
}
