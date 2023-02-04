import Vapor
import Fluent
import Entity

final class SourceCodeModel: Model {
    
    static let schema = "source_codes"
    
    @ID(key: "id")
    var id: UUID?
    
    @Field(key: "filename")
    var filename: String
    
    @Field(key: "code")
    var code: String
    
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
        code: String,
        commitID: CommitModel.IDValue
    ) {
        self.id = id
        self.filename = filename
        self.code = code
        self.$commit.id = commitID
    }
    
    func source() throws -> CommitSourceFile {
        try .init(
            id: .init(value: requireID()),
            filename: .init(filename),
            text: .init(code)
        )
    }
}
