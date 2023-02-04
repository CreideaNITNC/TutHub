public struct SignUser: Identifiable, Hashable, Equatable {
    
    public var id: UserID
    
    public var username: Username
    
    public var mailAddress: MailAddress
    
    public var passwordHash: UserPasswordHash
    
    public var user: User {
        .init(id: id)
    }
    
    public init(id: UserID, username: Username, mailAddress: MailAddress, passwordHash: UserPasswordHash) {
        self.id = id
        self.username = username
        self.mailAddress = mailAddress
        self.passwordHash = passwordHash
    }
}
