import Vapor

struct BearerTokenContent: Content {
    var token: UUID
}
