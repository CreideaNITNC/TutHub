import Vapor
import Fluent

struct UserSessionAuthenticator: AsyncSessionAuthenticator {
    
    typealias User = App.SessionAuthUserModel
    
    func authenticate(sessionID: UUID, for request: Request) async throws {
        guard let sessionAuthUser = try await SessionAuthUserModel.query(on: request.db)
            .filter(\.$sessionID == sessionID)
            .first()
        else { return }
        request.auth.login(sessionAuthUser)
    }
}
