import Vapor

protocol SignUserRepository {
    
    func verify(_ user: SignInUserContent) async throws -> User?
    
    func signUp(_ user: SignUpUserContent) async throws -> User
    
}
