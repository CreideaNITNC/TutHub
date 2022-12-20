import Vapor

struct SignController: RouteCollection {
    
    func boot(routes: RoutesBuilder) throws {
        let sign = routes.grouped("sign")
        sign.post("in", use: signIn)
        sign.post("up", use: signUp)
    }
    
    func signIn(req: Request) async throws -> View {
        let signInUser = try req.content.decode(SignInUserContent.self)
        guard let user = try await req.signUserRepository.verify(signInUser) else {
            return try await req.signViewRender.render(isFailed: true, isAlreadyRegistered: false)
        }
        try await req.login(user)
        return try await req.homeViewRender.render()
    }
    
    func signUp(req: Request) async throws -> View {
        let signUpUser = try req.content.decode(SignUpUserContent.self)
        guard let user = try? await req.signUserRepository.signUp(signUpUser) else {
            return try await req.signViewRender.render(isFailed: false, isAlreadyRegistered: true)
        }
        try await req.login(user)
        return try await req.homeViewRender.render()
    }
}
