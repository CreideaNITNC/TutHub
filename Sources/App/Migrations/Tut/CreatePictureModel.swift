import Vapor
import Fluent

extension PictureModel {
    struct Migration: AsyncMigration {
        func prepare(on database: Database) async throws {
            let sample = PictureModel()
            try await database.schema(PictureModel.schema)
                .id()
                .field(sample.$filename.key, .string, .required)
                .field(sample.$bin.key, .data, .required)
                .field(sample.$commit.$id.key, .uuid, .required, .references(CommitModel.schema, CommitModel().$id.key, onDelete: .cascade))
                .field(sample.$createdAt.$timestamp.key, .date, .required)
                .field(sample.$updatedAt.$timestamp.key, .date, .required)
                .create()
        }
        
        func revert(on database: FluentKit.Database) async throws {
            try await database.schema(PictureModel.schema).delete()
        }
    }
}
