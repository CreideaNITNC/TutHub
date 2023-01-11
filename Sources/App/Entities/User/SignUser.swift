struct SignUser: Identifiable, Hashable, Equatable {
    
    var id: UserID
    
    var username: Username
    
    var mailAddress: MailAddress
    
    var passwordHash: UserPasswordHash
    
    var user: User {
        .init(id: id)
    }
}
