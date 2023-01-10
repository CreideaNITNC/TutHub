import Vapor
import Fluent

final class SectionModel: Model {
    
    static let schema = "sections"
    
    @ID(key: "id")
    var id: UUID?
    
    @Field(key: "name")
    var name: String
    
    @Field(key: "number")
    var number: Int
    
    @Parent(key: "repository_id")
    var repository: TutHubRepositoryModel
    
    @Children(for: \.$section)
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
    
    func contentSection() throws -> ContentSection {
        try .init(
            id: .init(value: requireID()),
            title: .init(name),
            commits: commits.sorted { $0.step < $1.step }.map { try $0.commit() }
        )
    }
}
