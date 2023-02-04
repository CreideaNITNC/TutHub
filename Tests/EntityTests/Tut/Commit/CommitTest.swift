@testable import Entity
import XCTest

final class CommitTest: XCTestCase {

    func test_等価() throws {
        let id = CommitID(value: UUID())
        
        let commit1 = try Commit(
            id: id,
            message: .init("hello"),
            codes: [],
            pictures: []
        )
        
        let commit2 = try Commit(
            id: id,
            message: .init("hello"),
            codes: [],
            pictures: []
        )
        
        XCTAssertTrue(commit1 == commit2)
    }
    
    func test_不等価() throws {
        let commit1 = try Commit(
            id: .init(value: UUID()),
            message: .init("hello"),
            codes: [],
            pictures: []
        )
        
        let commit2 = try Commit(
            id: .init(value: UUID()),
            message: .init("hello"),
            codes: [],
            pictures: []
        )
        
        XCTAssertFalse(commit1 == commit2)
    }
}
