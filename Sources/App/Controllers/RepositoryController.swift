import Vapor
import Fluent

struct RepositoryController: RouteCollection {
    
    func boot(routes: RoutesBuilder) throws {
        let repository = routes.grouped("repository")
        repository.get(use: index)
        repository.post(use: create)
        repository.delete("*", ":repository", use: delete)
    }
    
    func index(req: Request) async throws -> View {
        try await req.homeViewRender().render()
    }
    
    func create(req: Request) async throws -> View {
        struct Create: Content {
            var name: String
        }
        let create = try req.content.decode(Create.self)
        let user = try req.requireUser()
        try await TutHubRepositoryModel(name: create.name, userID: user.id.value).create(on: req.db)
        return try await req.homeViewRender().render()
    }
    
    func delete(req: Request) async throws -> View {
        guard let reposiotryName = req.parameters.get("repository") else {
            throw Abort(.badRequest)
        }
        
        let user = try req.requireUser()
        try await TutHubRepositoryModel.query(on: req.db)
            .filter(\.$userModel.$id == user.id.value)
            .filter(\.$name == reposiotryName)
            .delete()
        return try await index(req: req)
    }
}
