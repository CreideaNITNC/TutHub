import Vapor
import Fluent

final class BearerTokenModel: Model {
    
    static let schema = "bearer_tokens"
    
    @ID(key: "id")
    var id: UUID?
    
    @Parent(key: "user_id")
    var userModel: UserModel
    
    @Timestamp(key: "created_at", on: .create)
    var createdAt: Date?
    
    init() { }
    
    init(id: UUID? = nil, userID: UserModel.IDValue) {
        self.id = id
        self.$userModel.id = userID
    }
    
    var user: User {
        .init(id: .init(value: self.$userModel.id))
    }
    
    static func generate(user: User, on db: Database) async throws -> UUID {
        let token = Self.init(userID: user.id.value)
        try await token.create(on: db)
        return try token.requireID()
    }
}
