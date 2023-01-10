import Vapor

struct UsernameSignInUserContent: Content {
    
    var name: String
    
    var password: String
    
    var getUsername: Username {
        get throws {
            try .init(name)
        }
    }
}
