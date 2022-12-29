import Vapor


struct TutController: RouteCollection {
    
    var cache: TutorialPageDataCache
    
    func boot(routes: RoutesBuilder) throws {
        let tut = routes.grouped("tut")
            .grouped(UserBasicAuthenticator())
            .grouped(User.guardMiddleware())
        tut.post(":username", ":repository", use: push)
    }
    
    func push(req: Request) async throws -> HTTPStatus {
        guard
            let username = try req.parameters.get("username").map(Username.init),
            let repositoryName = try req.parameters.get("repository").map(RepositoryName.init)
        else { throw Abort(.badRequest) }
        let data = try req.content.decode(PushData.self)
        
        let user = try req.requireUser()
        
        try await req.pushService.push(user, username, repositoryName, data)
        
        await cache.remove(username, repositoryName)
        
        return .created
    }
}
