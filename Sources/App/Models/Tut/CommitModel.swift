import Vapor
import Fluent

final class CommitModel: Model {
    
    static let schema = "commits"
    
    @ID(key: "id")
    var id: UUID?
    
    @Field(key: "step")
    var step: Int
    
    @Field(key: "message")
    var message: String
    
    @Parent(key: "tag_id")
    var tag: TagModel
    
    @Children(for: \.$commit)
    var codes: [SourceCodeModel]
    
    
    @Children(for: \.$commit)
    var pictures: [PictureModel]
    
    @Timestamp(key: "created_at", on: .create)
    var createdAt: Date?
    
    @Timestamp(key: "updated_at", on: .update)
    var updatedAt: Date?
    
    init() { }
    
    init(id: UUID? = nil, step: Int, message: String, tagID: TagModel.IDValue) {
        self.id = id
        self.step = step
        self.message = message
        self.$tag.id = tagID
    }
}
