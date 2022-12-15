import Vapor

struct TutorialPageData: Content {
    var userID: String
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
    }
    
    struct Code: Content {
        var filename: String
        var code: String
    }
    
    struct Picture: Content {
        var filename: String
        var encodedBinaryData: String
    }
    
    struct OverView: Content {
        var message: String
        var ncodedBinaryPictureData: String?
    }
}
