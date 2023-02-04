import Vapor
import Entity

public struct TutorialPageData: Content {
    var username: String
    var repositoryName: String
    var pageNumber: Int
    var pageTitle: String
    var commits: [Commit]
    var next: OverView?
    
    public struct Commit: Content {
        var step: Int
        var message: String
        var codes: [Code]
        var pictures: [Picture]
        
        public init(_ step: Int, _ commit: Entity.Commit) {
            self.step = step
            self.message = commit.message.value
            self.codes = commit.codes.map { .init($0) }
            self.pictures = commit.pictures.map { .init($0) }
        }
    }
    
    public struct Code: Content {
        var filename: String
        var code: String
        
        public init(_ source: CommitSourceFile) {
            self.filename = source.filename.value
            self.code = source.text.value
        }
    }
    
    public struct Picture: Content {
        var filename: String
        var `extension`: PictureFileExtension
        var encodedBinaryData: Data
        
        public init(_ picture: CommitPicture) {
            self.filename = picture.filename.value
            self.`extension` = picture.`extension`
            self.encodedBinaryData = picture.binary.value
        }
    }
    
    public struct OverView: Content {
        var message: String
        var ncodedBinaryPictureData: String?
        
        public init(message: String, ncodedBinaryPictureData: String? = nil) {
            self.message = message
            self.ncodedBinaryPictureData = ncodedBinaryPictureData
        }
    }
    
    public init(_ username: Username, _ repositoryName: RepositoryName, _ page: SectionPage, _ content: ContentSection) {
        self.username = username.value
        self.repositoryName = repositoryName.value
        self.pageNumber = page.value
        self.pageTitle = content.title.value
        self.commits = content.commits.enumerated().map { .init($0.offset, $0.element) }
    }
}
