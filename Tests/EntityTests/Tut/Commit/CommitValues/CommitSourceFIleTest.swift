@testable import Entity
import XCTest

final class CommitSourceFileTest: XCTestCase {

    func test_等価() throws {
        let id = SourceCodeID(value: UUID())
        
        let code1 = CommitSourceFile(
            id: id,
            filename: try .init("hello.swift"),
            text: try .init("print(\"Hello, World!\")")
        )
        let code2 = CommitSourceFile(
            id: id,
            filename: try .init("hello.swift"),
            text: try .init("print(\"Hello, World!\")")
        )
        XCTAssertTrue(code1 == code2)
    }
    
    func test_不等価() throws {
        let code1 = CommitSourceFile(
            id: SourceCodeID(value: UUID()),
            filename: try .init("hello.swift"),
            text: try .init("print(\"Hello, World!\")")
        )
        let code2 = CommitSourceFile(
            id: SourceCodeID(value: UUID()),
            filename: try .init("hello.swift"),
            text: try .init("print(\"Hello, World!\")")
        )
        XCTAssertFalse(code1 == code2)
    }
}
