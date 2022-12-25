import Vapor

struct UsernameSignInUserContent: Content {
    
    var name: String
    
    var password: String
    
    func getUsername() throws -> Username {
        try .init(name)
    }
}
