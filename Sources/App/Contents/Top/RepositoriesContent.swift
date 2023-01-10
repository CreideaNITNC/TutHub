import Vapor

struct RepositoriesContent: Content {
    
    var repositories: [Repository]
    
    struct Repository: Content {
        var name: String
        var title: String
        var remoteURL: String
        var webURL: String
    }
}
