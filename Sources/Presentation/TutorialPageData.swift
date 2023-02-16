import Vapor
import Entity

public struct TutorialPageData: Content {
    public var username: String
    public var repositoryName: String
    public var repositoryTitle: String
    public var pageNumber: Int
    public var pageTitle: String
    public var commits: [Commit]
    public var next: OverView?
    
    public struct Commit: Content {
        public var step: Int
        public var message: String
        public var codes: [Code]
        public var pictures: [Picture]
        
        public init(_ step: Int, _ commit: Entity.Commit) {
            self.step = step
            self.message = commit.message.value
            self.codes = commit.codes.map { .init($0) }
            self.pictures = commit.pictures.map { .init($0) }
        }
    }
    
    public struct Code: Content {
        public var filename: String
        public var code: String
        
        public init(_ source: CommitSourceFile) {
            self.filename = source.filename.value
            self.code = source.text.value
        }
    }
    
    public struct Picture: Content {
        public var filename: String
        public var `extension`: PictureFileExtension
        public var encodedBinaryData: Data
        
        public init(_ picture: CommitPicture) {
            self.filename = picture.filename.value
            self.`extension` = picture.`extension`
            self.encodedBinaryData = picture.binary.value
        }
    }
    
    public struct OverView: Content {
        public var message: String
        public var ncodedBinaryPictureData: String?
        
        public init(message: String, ncodedBinaryPictureData: String? = nil) {
            self.message = message
            self.ncodedBinaryPictureData = ncodedBinaryPictureData
        }
    }
    
    public init(
        _ username: Username,
        _ repositoryName: RepositoryName,
        _ repositoryTitle: RepositoryTitle,
        _ page: SectionPage,
        _ content: ContentSection
    ) {
        self.username = username.value
        self.repositoryName = repositoryName.value
        self.repositoryTitle = repositoryTitle.value
        self.pageNumber = page.value
        self.pageTitle = content.title.value
        self.commits = content.commits.enumerated().map { .init($0.offset, $0.element) }
    }
}
