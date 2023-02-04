import Vapor
import Fluent
import Entity

extension User: Authenticatable {}

struct UserBasicAuthenticator: AsyncBasicAuthenticator {
    
    typealias User = Entity.User
    
    func authenticate(
        basic: BasicAuthorization,
        for request: Request
    ) async throws {
        let username = try Username(basic.username)
        guard let signUser = try await request.signUserRepository.find(username) else {
            return
        }
        if try await request.password.async.verify(basic.password, created: signUser.passwordHash.value) {
            request.auth.login(signUser.user)
        }
    }
}
