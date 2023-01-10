import Vapor

protocol UsernameRepository {
    
    func find(_ id: UserID) async throws -> Username?
    
    func user(_ username: Username) async throws -> User?
    
}

extension Request {
    var usernameRepository: UsernameRepository {
        DatabaseUsernameRepository(db: db)
    }
}
