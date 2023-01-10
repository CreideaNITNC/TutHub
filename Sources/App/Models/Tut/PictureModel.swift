import Vapor
import Fluent


final class PictureModel: Model {
    
    static let schema = "pictures"
    
    @ID(key: "id")
    var id: UUID?
    
    @Field(key: "filename")
    var filename: String
    
    @Enum(key: "extension")
    var `extension`: PictureFileExtension
    
    @Field(key: "bin")
    var bin: Data
    
    @Field(key: "number")
    var number: Int
    
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
        extension: PictureFileExtension,
        bin: Data,
        number: Int,
        commitID: CommitModel.IDValue
    ) {
        self.id = id
        self.filename = filename
        self.`extension` = `extension`
        self.bin = bin
        self.number = number
        self.$commit.id = commitID
    }
    
    func picture() throws -> CommitPicture {
        try .init(
            id: .init(value: requireID()),
            binary: .init(bin),
            filename: .init(filename),
            extension: self.extension
        )
    }
}

