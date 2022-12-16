import Vapor

struct RepositoriesContent: Content {
    
    var repositories: [Repository]
    
    struct Repository: Content {
        var name: String
        var link: String
    }
}
