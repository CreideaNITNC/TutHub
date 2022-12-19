import Vapor
import Fluent

final class PictureModel: Model {
    
    static let schema = "pictures"
    
    @ID(key: "id")
    var id: UUID?
    
    @Field(key: "filename")
    var filename: String
    
    @Field(key: "bin")
    var bin: Data
    
    @Parent(key: "commit_id")
    var commit: CommitModel
    
    @Timestamp(key: "created_at", on: .create)
    var createdAt: Date?
    
    @Timestamp(key: "updated_at", on: .update)
    var updatedAt: Date?
    
    init() { }
    
    init(
        id: UUID? = nil,
        filename: String,
        bin: Data,
        commitID: CommitModel.IDValue
    ) {
        self.id = id
        self.filename = filename
        self.bin = bin
        self.$commit.id = commitID
    }
}

