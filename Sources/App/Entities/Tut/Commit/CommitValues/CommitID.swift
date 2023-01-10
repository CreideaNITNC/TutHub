import Vapor

struct CommitID: Hashable, Equatable {
    var value: UUID
}
