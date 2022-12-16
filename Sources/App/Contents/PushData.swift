import Vapor

struct PushData: Content {
    
    var tags: [Self.Tag]
    
    struct Tag: Content {
        var id: UUID
        var name: String
        var commits: [Commit]
    }

    struct Commit: Content {
        var id: UUID
        var message: String
        var files: [File]
    }

    struct File: Content {
        var name: String
        var type: FileType
        var content: String
    }
    
    enum FileType: String, Content {
        case image, text
    }
    
}
