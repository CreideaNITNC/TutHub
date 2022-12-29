import Fluent
import Vapor

func routes(_ app: Application) throws {
    app.post("tanaka", "vapor") { req in
        HTTPStatus.created
    }
    
    app.get { req async throws -> View in
        try await req.signViewRender.render(isFailed: false, isAlreadyRegistered: false)
    }
    
    let tutHubPageDataCache = TutorialPageDataCache()
    
    try app.register(collection: SignController())
    try app.register(collection: RepositoryController())
    try app.register(collection: TutController(cache: tutHubPageDataCache))
    try app.register(collection: TutHubPageController(cache: tutHubPageDataCache))
}
