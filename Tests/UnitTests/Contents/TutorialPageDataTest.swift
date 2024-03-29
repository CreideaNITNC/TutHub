@testable import App
import Entity
import Presentation
import XCTest

final class TutrialPageDataTest: XCTestCase {
    
    func test_initialize() throws {
        let username = try Username("Bob")
        let repositoryName = try RepositoryName("Hello-World")
        let repositoryTitle = try RepositoryTitle("Hello, World!")
        let page = try SectionPage(1)
        let sectionID = SectionID(value: UUID())
        let content = ContentSection(
            id: sectionID,
            title: try .init("タイトル"),
            commits: []
        )
        
        let data = TutorialPageData(username, repositoryName, repositoryTitle, page, content)
        
        XCTAssertEqual(data.username, "Bob")
        XCTAssertEqual(data.repositoryName, "Hello-World")
        XCTAssertEqual(data.repositoryTitle, "Hello, World!")
        XCTAssertEqual(data.pageTitle, "タイトル")
        XCTAssertEqual(data.pageNumber, 1)
        
    }
}
