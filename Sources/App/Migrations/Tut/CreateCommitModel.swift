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
                .field(sample.$section.$id.key, .uuid, .required, .references(SectionModel.schema, SectionModel().$id.key, onDelete: .cascade))
                .field(sample.$createdAt.$timestamp.key, .datetime, .required)
                .field(sample.$updatedAt.$timestamp.key, .datetime, .required)
                .create()
        }
        
        func revert(on database: FluentKit.Database) async throws {
            try await database.schema(CommitModel.schema).delete()
        }
    }
}
