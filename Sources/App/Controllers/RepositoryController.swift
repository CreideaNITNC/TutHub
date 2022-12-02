import Vapor
import Fluent

struct RepositoryController: RouteCollection {
    
    func boot(routes: RoutesBuilder) throws {
        routes.get(use: index)
    }
    
    func index(req: Request) async throws -> View {
        return try await req.view.render("index", ["title": "Hello, TutHub!"])
    }
}
