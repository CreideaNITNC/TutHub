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
                .field(sample.$createdAt.$timestamp.key, .datetime, .required)
                .field(sample.$updatedAt.$timestamp.key, .datetime, .required)
                .create()
        }
        
        func revert(on database: Database) async throws {
            try await database.schema(SourceCodeModel.schema).delete()
        }
    }
}
