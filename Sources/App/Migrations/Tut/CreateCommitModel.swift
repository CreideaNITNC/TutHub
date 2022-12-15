import Vapor
import Fluent

extension CommitModel {
    struct Migration: AsyncMigration {
        func prepare(on database: Database) async throws {
            let sample = CommitModel()
            try await database.schema(CommitModel.schema)
                .id()
                .field(sample.$step.key, .uint, .required)
                .field(sample.$message.key, .string, .required)
                .field(sample.$tag.$id.key, .uuid, .required, .references(TagModel.schema, TagModel().$id.key, onDelete: .cascade))
                .field(sample.$createdAt.$timestamp.key, .date, .required)
                .field(sample.$updatedAt.$timestamp.key, .date, .required)
                .create()
        }
        
        func revert(on database: FluentKit.Database) async throws {
            try await database.schema(CommitModel.schema).delete()
        }
    }
}
