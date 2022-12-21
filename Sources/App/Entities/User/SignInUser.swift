import Vapor

struct SignInUser: Identifiable, Hashable, Equatable {
    
    var id: UserID
    
    var username: String
    
    var passwordHash: String
    
}
