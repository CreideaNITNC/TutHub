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
            var title: String
            
            func getRepositoryName() throws -> RepositoryName {
                try .init(name)
            }
            
            func getRepositoryTitle() throws -> RepositoryTitle {
                try .init(title)
            }
        }
        let create = try req.content.decode(Create.self)
        let user = try req.requireUser()
        try await req.repositoryListService.append(user, create.getRepositoryName(), create.getRepositoryTitle())
        return try await req.homeViewRender().render()
    }
    
    func delete(req: Request) async throws -> View {
        guard let reposiotryName = try req.parameters.get("repository").map(RepositoryName.init) else {
            throw Abort(.badRequest)
        }
        let user = try req.requireUser()
        try await req.repositoryListService.remove(user, reposiotryName)
        return try await index(req: req)
    }
}
