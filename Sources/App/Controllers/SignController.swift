import Vapor

struct SignController: RouteCollection {
    
    func boot(routes: RoutesBuilder) throws {
        let sign = routes.grouped("sign")
        sign.post("in", use: signIn)
        sign.post("up", use: signUp)
    }
    
    func signIn(req: Request) async throws -> View {
        let signUser = try req.content.decode(SignUserContent.self)
        guard let user = try await req.signUserRepository.verify(signUser) else {
            return try await req.signViewRender.render(isFailed: true, isAlreadyRegistered: false)
        }
        try await req.login(user)
        return try await req.homeViewRender.render()
    }
    
    func signUp(req: Request) async throws -> View {
        let signUser = try req.content.decode(SignUserContent.self)
        guard let user = try? await req.signUserRepository.signUp(signUser) else {
            return try await req.signViewRender.render(isFailed: false, isAlreadyRegistered: true)
        }
        try await req.login(user)
        return try await req.homeViewRender.render()
    }
}
