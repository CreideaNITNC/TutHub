import Vapor

protocol SignUserRepository {
    
    func isVerify(_ user: SignUserContent) async throws -> User?
    
    func signUp(_ user: SignUserContent) async throws -> User
    
}
