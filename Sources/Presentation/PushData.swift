import Vapor
import Entity

public struct PushData: Content {
    
    var sections: [Self.Section]
    
    public func contentRepository(_ id: RepositoryID) throws -> TutHubContentRepository {
        try .init(
            id: id,
            sections: sections.map { try $0.contentSection() }
        )
    }
    
    struct Section: Content {
        var id: UUID
        var name: String
        var commits: [Commit]
        
        func contentSection() throws -> ContentSection {
            try .init(
                id: .init(value: UUID()),
                title: .init(name),
                commits: commits.map { try $0.commit() }
            )
        }
    }

    struct Commit: Content {
        var id: UUID
        var message: String
        var pictures: [Picture]
        var codes: [SourceCode]
        
        func commit() throws -> Entity.Commit {
            try .init(
                id: .init(value: UUID()),
                message: .init(message),
                codes: codes.map { try $0.sourceFile() },
                pictures: pictures.map { try $0.commitPicture() }
            )
        }
    }
    
    struct SourceCode: Content {
        var name: String
        var content: String
        
        func sourceFile() throws -> CommitSourceFile {
            try .init(
                id: .init(value: UUID()),
                filename: .init(name),
                text: .init(content)
            )
        }
    }
    
    struct Picture: Content {
        var name: String
        var `extension`: PictureFileExtension
        var bin: Data
        
        func commitPicture() throws -> CommitPicture {
            try .init(
                id: .init(value: UUID()),
                binary: .init(bin),
                filename: .init(name),
                extension: `extension`
            )
        }
    }
}
