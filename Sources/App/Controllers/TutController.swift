import Vapor

struct TutController: RouteCollection {
    
    func boot(routes: RoutesBuilder) throws {
        let tut = routes.grouped("tut")
        tut.post(":userID", ":repository", use: push)
    }
    
    func push(req: Request) async throws -> HTTPStatus {
        let userID = req.parameters.get("userID", as: UUID.self)!
        let repositoryName = req.parameters.get("repository")!
        let data = try req.content.decode(PushData.self)
        
        try await req.tutPushRepository.push(userID: userID, repositoryName: repositoryName, data: data)
        return .created
    }
}
