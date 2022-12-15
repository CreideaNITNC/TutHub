import Vapor
import Fluent

extension SourceCodeModel {
    struct Migration: AsyncMigration {
        func prepare(on database: Database) async throws {
            let sample = SourceCodeModel()
            try await database.schema(SourceCodeModel.schema)
                .id()
                .field(sample.$filename.key, .string, .required)
                .field(sample.$code.key, .string, .required)
                .field(sample.$commit.$id.key, .uuid, .required, .references(CommitModel.schema, CommitModel().$id.key, onDelete: .cascade))
                .field(sample.$createdAt.$timestamp.key, .date, .required)
                .field(sample.$updatedAt.$timestamp.key, .date, .required)
                .create()
        }
        
        func revert(on database: FluentKit.Database) async throws {
            try await database.schema(SourceCodeModel.schema).delete()
        }
    }
}