import Vapor

struct TutorialPageData: Content {
    var username: String
    var repositoryName: String
    var pageNumber: Int
    var pageTitle: String
    var commits: [Commit]
    var next: OverView?
    
    struct Commit: Content {
        var step: Int
        var message: String
        var codes: [Code]
        var pictures: [Picture]
        
        init(_ step: Int, _ commit: App.Commit) {
            self.step = step
            self.message = commit.message.value
            self.codes = commit.codes.map { .init($0) }
            self.pictures = commit.pictures.map { .init($0) }
        }
    }
    
    struct Code: Content {
        var filename: String
        var code: String
        
        init(_ source: CommitSourceFile) {
            self.filename = source.filename.value
            self.code = source.text.value
        }
    }
    
    struct Picture: Content {
        var filename: String
        var `extension`: PictureFileExtension
        var encodedBinaryData: Data
        
        init(_ picture: CommitPicture) {
            self.filename = picture.filename.value
            self.`extension` = picture.`extension`
            self.encodedBinaryData = picture.binary.value
        }
    }
    
    struct OverView: Content {
        var message: String
        var ncodedBinaryPictureData: String?
    }
    
    init(_ username: Username, _ repositoryName: RepositoryName, _ page: SectionPage, _ content: ContentSection) {
        self.username = username.value
        self.repositoryName = repositoryName.value
        self.pageNumber = page.value
        self.pageTitle = content.title.value
        self.commits = content.commits.enumerated().map { .init($0.offset, $0.element) }
    }
}
