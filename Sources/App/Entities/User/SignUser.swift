import Vapor

struct SignUser: Identifiable, Hashable, Equatable {
    
    var id: UserID
    
    var username: Username
    
    var mailAddress: MailAddress
    
    var passwordHash: UserPasswordHash
    
}
