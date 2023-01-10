import Fluent
import Vapor
import Leaf

func routes(_ app: Application) throws {
    app.post("tanaka", "vapor") { req in
        HTTPStatus.created
    }
    
    app.get("test") { req async throws -> View in
        try await req.leaf.render("test")
    }
    
    let tutHubPageDataCache = TutorialPageDataCache()
    
    try app.register(collection: SignController())
    try app.register(collection: RepositoryController())
    try app.register(collection: TutController(cache: tutHubPageDataCache))
    try app.register(collection: TutHubPageController(cache: tutHubPageDataCache))
}
