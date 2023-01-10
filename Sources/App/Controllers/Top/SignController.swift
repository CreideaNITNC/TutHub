import Vapor
import Fluent

struct SignController: RouteCollection {
    
    func boot(routes: RoutesBuilder) throws {
        let sign = routes.grouped("sign")
        sign.post("in", "mail", use: mailSignIn)
        sign.post("in", "name", use: nameSignIn)
        sign.post("up", use: signUp)
    }
    
    func nameSignIn(req: Request) async throws -> BearerTokenContent {
        let signInUser = try req.content.decode(UsernameSignInUserContent.self)
        guard let user = try await req.signService.signIn(signInUser) else {
            throw Abort(.unauthorized, reason: "ユーザー名またはパスワードが違います")
        }
        return try await publish(user, on: req.db)
    }
    
    func mailSignIn(req: Request) async throws -> BearerTokenContent {
        let signInUser = try req.content.decode(MailAddressSignInUserContent.self)
        guard let user = try await req.signService.signIn(signInUser) else {
            throw Abort(.unauthorized, reason: "メールアドレスまたはパスワードが違います")
        }
        return try await publish(user, on: req.db)
    }
    
    func signUp(req: Request) async throws -> BearerTokenContent {
        let signUpUser = try req.content.decode(SignUpUserContent.self)
        guard let user = try await req.signService.signUp(signUpUser) else {
            throw Abort(.unauthorized, reason: "メールアドレスまたは名前がすでに登録されています")
        }
        return try await publish(user, on: req.db)
    }
    
    func publish(_ user: User, on db: Database) async throws -> BearerTokenContent {
        let token = try await BearerTokenModel.generate(user: user, on: db)
        return BearerTokenContent(token: token)
    }
}
