import Vapor

protocol SignUserRepository {
    
    func verify(_ user: SignUserContent) async throws -> User?
    
    func signUp(_ user: SignUserContent) async throws -> User
    
}
