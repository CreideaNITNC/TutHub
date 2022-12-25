import Vapor
import Fluent

final class SessionAuthUserModel: Model, SessionAuthenticatable {
    
    static let schema = "session_auth_users"
    
    @ID(key: "id")
    var id: UUID?
    
    @Field(key: "session")
    var sessionID: UUID
    
    @Field(key: "user_id")
    var userID: UUID
    
    @Timestamp(key: "created_at", on: .create)
    var createdAt: Date?
    
    init() { }
    
    init(id: UUID? = nil, userID: UUID) {
        self.id = id
        self.userID = userID
        self.sessionID = UUID()
    }
    
    var user: User {
        .init(id: .init(value: userID))
    }
    
}
