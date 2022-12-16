import Vapor
import Fluent

final class TagModel: Model {
    
    static let schema = "tags"
    
    @ID(key: "id")
    var id: UUID?
    
    @Field(key: "name")
    var name: String
    
    @Field(key: "number")
    var number: Int
    
    @Parent(key: "repository_id")
    var repository: TutHubRepositoryModel
    
    @Children(for: \.$tag)
    var commits: [CommitModel]
    
    @Timestamp(key: "created_at", on: .create)
    var createdAt: Date?
    
    @Timestamp(key: "updated_at", on: .update)
    var updatedAt: Date?
    
    init() { }
    
    init(
        id: UUID? = nil,
        name: String,
        number: Int,
        repositoryID: TutHubRepositoryModel.IDValue
    ) {
        self.id = id
        self.name = name
        self.number = number
        self.$repository.id = repositoryID
    }
}
