import Vapor

struct User: Equatable, Hashable, Identifiable {
    var id: UUID
}
