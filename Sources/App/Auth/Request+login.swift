import Vapor

extension Request {
    func sessionLogin(_ user: User) async throws {
        let authUser = SessionAuthUserModel(userID: user.id.value)
        try await authUser.create(on: db)
        self.auth.login(authUser)
    }
    
    func requireUser() throws -> User {
        try auth.get(User.self) ?? auth.require(SessionAuthUserModel.self).user
    }
    
    var user: User? {
        auth.get(User.self) ?? auth.get(SessionAuthUserModel.self)?.user
    }
}
