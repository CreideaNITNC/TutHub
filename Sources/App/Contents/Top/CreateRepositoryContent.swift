import Vapor
import Entity

struct CreateRepositoryContent: Content {
    
    var name: String
    
    var title: String
    
    var getName: RepositoryName {
        get throws {
            try .init(name)
        }
    }
    
    var getTitle: RepositoryTitle {
        get throws {
            try .init(title)
        }
    }
}
