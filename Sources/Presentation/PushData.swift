import Vapor
import Entity

public struct PushData: Content {
    
    public var sections: [Self.Section]
    
    public init(sections: [Self.Section]) {
        self.sections = sections
    }
    
    public func contentRepository(_ id: RepositoryID) throws -> TutHubContentRepository {
        try .init(
            id: id,
            sections: sections.map { try $0.contentSection() }
        )
    }
    
    public struct Section: Content {
        public var id: UUID
        public var name: String
        public var commits: [Commit]
        
        public init(id: UUID, name: String, commits: [Commit]) {
            self.id = id
            self.name = name
            self.commits = commits
        }
        
        func contentSection() throws -> ContentSection {
            try .init(
                id: .init(value: UUID()),
                title: .init(name),
                commits: commits.map { try $0.commit() }
            )
        }
    }

    public struct Commit: Content {
        public var id: UUID
        public var message: String
        public var pictures: [Picture]
        public var codes: [SourceCode]
        
        func commit() throws -> Entity.Commit {
            try .init(
                id: .init(value: UUID()),
                message: .init(message),
                codes: codes.map { try $0.sourceFile() },
                pictures: pictures.map { try $0.commitPicture() }
            )
        }
        
        public init(id: UUID, message: String, pictures: [Picture], codes: [SourceCode]) {
            self.id = id
            self.message = message
            self.pictures = pictures
            self.codes = codes
        }
    }
    
    public struct SourceCode: Content {
        public var name: String
        public var content: String
        
        func sourceFile() throws -> CommitSourceFile {
            try .init(
                id: .init(value: UUID()),
                filename: .init(name),
                text: .init(content)
            )
        }
        
        public init(name: String, content: String) {
            self.name = name
            self.content = content
        }
    }
    
    public struct Picture: Content {
        public var name: String
        public var `extension`: PictureFileExtension
        public var bin: Data
        
        func commitPicture() throws -> CommitPicture {
            try .init(
                id: .init(value: UUID()),
                binary: .init(bin),
                filename: .init(name),
                extension: `extension`
            )
        }
        
        public init(name: String, `extension`: PictureFileExtension, bin: Data) {
            self.name = name
            self.`extension` = `extension`
            self.bin = bin
        }
    }
}
