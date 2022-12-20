import Vapor

protocol UsernameRepository {
    
    func find(_ user: User) async throws -> String?
    
    func user(_ username: String) async throws -> User?
    
}
