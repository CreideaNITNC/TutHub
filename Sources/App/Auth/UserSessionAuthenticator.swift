import Vapor

extension User: SessionAuthenticatable {
    var sessionID: UUID {
        self.id
    }
}

struct UserSessionAuthenticator: AsyncSessionAuthenticator {
    
    typealias User = App.User
    
    func authenticate(sessionID: UUID, for request: Request) async throws {
        let user = User(id: sessionID)
        request.auth.login(user)
    }
}
