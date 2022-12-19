import Vapor
import Fluent

final class UserModel: Model {
    
    static let schema = "users"
    
    @ID(key: "id")
    var id: UUID?
    
    @OptionalChild(for: \.$userModel)
    var signUserModel: SignUserModel?
    
    @Children(for: \.$user)
    var repositories: [TutHubRepositoryModel]
    
    @Timestamp(key: "created_at", on: .create)
    var createdAt: Date?
    
    @Timestamp(key: "updated_at", on: .update)
    var updatedAt: Date?
    
    init() { }
    
    init(id: UUID? = nil) {
        self.id = id
    }
    
    var user: User {
        guard let id else { fatalError("required user, but id == nil") }
        return .init(id: id)
    }
    
}
