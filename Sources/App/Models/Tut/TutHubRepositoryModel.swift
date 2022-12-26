import Vapor
import Fluent

final class TutHubRepositoryModel: Model {
    
    static var schema = "repositories"
    
    @ID(key: "id")
    var id: UUID?
    
    @Field(key: "name")
    var name: String
    
    @Field(key: "title")
    var title: String
    
    @Parent(key: "user_id")
    var userModel: UserModel
    
    @Children(for: \.$repository)
    var sections: [SectionModel]
    
    @Timestamp(key: "created_at", on: .create)
    var createdAt: Date?
    
    @Timestamp(key: "updated_at", on: .update)
    var updatedAt: Date?
    
    init() { }
    
    init(id: UUID? = nil, name: String, title: String, userID: UserModel.IDValue) {
        self.id = id
        self.name = name
        self.title = title
        self.$userModel.id = userID
    }
}
