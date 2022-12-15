import Vapor
import Fluent

final class TutHubRepositoryModel: Model {
    
    static var schema = "repositories"
    
    @ID(key: "id")
    var id: UUID?
    
    @Field(key: "name")
    var name: String
    
    @Parent(key: "user_id")
    var user: UserModel
    
    @Children(for: \.$repository)
    var tags: [TagModel]
    
    @Timestamp(key: "created_at", on: .create)
    var createdAt: Date?
    
    @Timestamp(key: "updated_at", on: .update)
    var updatedAt: Date?
    
    init() { }
    
    init(id: UUID? = nil, name: String, userID: UserModel.IDValue) {
        self.id = id
        self.name = name
        self.$user.id = userID
    }
}
