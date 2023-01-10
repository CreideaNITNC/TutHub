import Vapor
import Fluent

struct UserBearerAuthenticator: AsyncBearerAuthenticator {
    
    func authenticate(bearer: Vapor.BearerAuthorization, for request: Vapor.Request) async throws {
        if
            let token = UUID(uuidString: bearer.token),
            let model = try await BearerTokenModel.find(token, on: request.db),
            let createAt = model.createdAt,
            createAt > Date(timeIntervalSinceNow: -24 * 60 * 60) /* 利用期限 1日 */
        {
            request.auth.login(model.user)
        }
    }
}
