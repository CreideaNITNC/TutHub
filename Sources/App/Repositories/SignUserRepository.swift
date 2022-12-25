import Vapor

protocol SignUserRepository {
    
    func find(_ name: Username) async throws -> SignUser?
    
    func find(_ mail: MailAddress) async throws -> SignUser?
    
    func isMailOrNameExits(_ name: Username, _ mail: MailAddress) async throws -> Bool
    
    func create(_ name: Username, _ mailAddress: MailAddress, _ passwordHash: UserPasswordHash) async throws -> SignUser
    
}

extension Request {
    var signUserRepository: SignUserRepository {
        DatabaseSignUserRepository(db: db)
    }
}
