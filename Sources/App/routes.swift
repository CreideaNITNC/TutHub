import Fluent
import Vapor

func routes(_ app: Application) throws {
    app.post("tanaka", "vapor") { req in
        HTTPStatus.created
    }

    app.get("delivery") { req in
        "delivery"
    }
}
