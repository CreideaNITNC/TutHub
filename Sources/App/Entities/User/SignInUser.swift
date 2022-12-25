import Vapor

struct SignInUser: Identifiable, Hashable, Equatable {
    
    var id: UserID
    
    var username: Username
    
    var passwordHash: UserPasswordHash
    
}
