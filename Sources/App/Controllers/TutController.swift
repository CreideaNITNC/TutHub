import Vapor


struct TutController: RouteCollection {
    
    func boot(routes: RoutesBuilder) throws {
        let tut = routes.grouped("tut")
            .grouped(UserBasicAuthenticator())
            .grouped(User.guardMiddleware())
        tut.post(":username", ":repository", use: push)
    }
    
    func push(req: Request) async throws -> HTTPStatus {
        let username = req.parameters.get("username")!
        let repositoryName = req.parameters.get("repository")!
        let data = try req.content.decode(PushData.self)
        
        let user = try req.requireUser()
        
        try await req.pushService.push(user, RepositoryName(repositoryName), data)
        return .created
    }
}
