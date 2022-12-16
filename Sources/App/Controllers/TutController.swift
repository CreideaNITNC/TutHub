import Vapor


struct TutController: RouteCollection {
    
    func boot(routes: RoutesBuilder) throws {
        let tut = routes.grouped("tut")
        tut.post(":userID", ":repository", use: push)
    }
    
    func push(req: Request) async throws -> HTTPStatus {
        print(req.body)
        let userID = req.parameters.get("userID", as: UUID.self)!
        let repositoryName = req.parameters.get("repository")!
        
        var data = try JSONDecoder().decode(PushData.self, from: ByteBuffer(string: req.body.string!))
        
        try await req.tutPushRepository.push(userID: userID, repositoryName: repositoryName, data: data)
        return .created
    }
}
