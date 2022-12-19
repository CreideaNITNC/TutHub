import Vapor

struct PushData: Content {
    
    var sections: [Self.Section]
    
    struct Section: Content {
        var id: UUID
        var name: String
        var commits: [Commit]
    }

    struct Commit: Content {
        var id: UUID
        var message: String
        var pictures: [Picture]
        var codes: [SourceCode]
    }
    
    struct SourceCode: Content {
        var name: String
        var content: String
    }
    
    struct Picture: Content {
        var name: String
        var bin: Data
    }
}
