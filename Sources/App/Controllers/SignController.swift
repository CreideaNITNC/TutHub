import Vapor

struct SignController: RouteCollection {
    
    func boot(routes: RoutesBuilder) throws {
        let sign = routes.grouped("sign")
        sign.post("name", "in", use: nameSignIn)
        sign.post("mail", "in", use: mailSignIn)
        sign.post("up", use: signUp)
    }
    
    func nameSignIn(req: Request) async throws -> View {
        let signInUser = try req.content.decode(UsernameSignInUserContent.self)
        guard try await req.signService.signIn(signInUser) else {
            return try await req.signViewRender.render(isFailed: true, isAlreadyRegistered: false)
        }
        return try await req.homeViewRender().render()
    }
    
    func mailSignIn(req: Request) async throws -> View {
        let signInUser = try req.content.decode(MailAddressSignInUserContent.self)
        guard try await req.signService.signIn(signInUser) else {
            return try await req.signViewRender.render(isFailed: true, isAlreadyRegistered: false)
        }
        return try await req.homeViewRender().render()
    }
    
    func signUp(req: Request) async throws -> View {
        let signUpUser = try req.content.decode(SignUpUserContent.self)
        guard let user = try await req.signService.signUp(signUpUser) else {
            return try await req.signViewRender.render(isFailed: false, isAlreadyRegistered: true)
        }
        try await req.sessionLogin(user)
        return try await req.homeViewRender().render()
    }
}
