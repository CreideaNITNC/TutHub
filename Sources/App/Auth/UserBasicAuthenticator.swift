import Vapor
import Fluent

extension User: Authenticatable {}

struct UserBasicAuthenticator: AsyncBasicAuthenticator {
    
    typealias User = App.User

    func authenticate(
        basic: BasicAuthorization,
        for request: Request
    ) async throws {
        guard let signUserModel = try await SignUserModel.query(on: request.db)
            .join(UserModel.self, on: \SignUserModel.$userModel.$id == \UserModel.$id)
            .filter(UserModel.self, \.$name == basic.username)
            .first()
        else { return  }
        
        let userModel = try signUserModel.joined(UserModel.self)
        
        if try await request.password.async.verify(basic.password, created: signUserModel.passwordHash) {
            request.auth.login(userModel.user)
        }
    }
}
