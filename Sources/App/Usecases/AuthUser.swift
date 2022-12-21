import Vapor

struct AuthUser: SessionAuthenticatable {
    
    var sessionID: UUID = UUID()
    
    var userID: User
    
}
