import Fluent
import Vapor

func routes(_ app: Application) throws {
    app.post("tanaka", "vapor") { req in
        HTTPStatus.created
    }
    
    try app.register(collection: RepositoryController())
}
