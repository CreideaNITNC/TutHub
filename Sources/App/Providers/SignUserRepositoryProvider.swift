import Vapor

extension Request {
    var signUserRepository: SignUserRepository {
        MockUserRepository()
    }
}


struct MockUserRepository: SignUserRepository {
    func isVerify(_ user: SignUserContent) async throws -> User? {
        nil
    }
    
    func signUp(_ user: SignUserContent) async throws -> User {
        .init(id: UUID())
    }
}
