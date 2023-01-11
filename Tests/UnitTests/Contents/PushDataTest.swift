@testable import App
import Entity
import XCTest

final class PushDataTest: XCTestCase {
    
    func test_変換() async throws {
        
        let pushData: PushData = .init(sections: [
            .init(id: UUID(), name: "環境構築", commits: [
                .init(
                    id: UUID(),
                    message: "メッセージ1",
                    pictures: [.init(name: "ピクチャ", extension: .png, bin: Data())],
                    codes: [.init(name: "コード.swift", content: "print()")]
                )
            ]),
        ])
        
        let repositoryID = RepositoryID(value: UUID())
        
        let converted = try pushData.contentRepository(repositoryID)
        
        let repository: TutHubContentRepository = try .init(
            id: repositoryID,
            sections: [.init(
                id: converted.sections[0].id,
                title: .init("環境構築"),
                commits: [.init(
                    id: converted.sections[0].commits[0].id,
                    message: .init("メッセージ1"),
                    codes: [.init(
                        id: converted.sections[0].commits[0].codes[0].id,
                        filename: .init("コード.swift"),
                        text: .init("print()")
                    )],
                    pictures: [.init(
                        id: converted.sections[0].commits[0].pictures[0].id,
                        binary: .init(Data()),
                        filename: .init("ピクチャ"),
                        extension: .png
                    )])
                ]
            )]
        )
        
        XCTAssertEqual(converted, repository)
        
    }
}
