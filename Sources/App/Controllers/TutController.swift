import Vapor
import Entity
import Presentation

struct TutController: RouteCollection {
    
    var cache: TutorialPageDataCache
    
    func boot(routes: RoutesBuilder) throws {
        let tut = routes.grouped("tut")
            .grouped(UserBasicAuthenticator())
            .grouped(User.guardMiddleware())
        tut.post(":username", ":repository", use: push)
    }
    
    func push(req: Request) async throws -> HTTPStatus {
        print("💌")
        guard
            let username = try req.parameters.get("username").map(Username.init),
            let repositoryName = try req.parameters.get("repository").map(RepositoryName.init)
        else { throw Abort(.badRequest) }
        print("❤️‍🩹")
        let data = try req.content.decode(PushData.self)
        print("💔")
        let user = try req.auth.require(User.self)
        
        try await req.pushService.push(user, username, repositoryName, data)
        
        await cache.remove(username, repositoryName)
        
        return .created
    }
}
