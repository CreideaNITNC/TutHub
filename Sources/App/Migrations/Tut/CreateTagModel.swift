import Vapor
import Fluent

extension TagModel {
    struct Migration: AsyncMigration {
        func prepare(on database: Database) async throws {
            let sample = TagModel()
            try await database.schema(TagModel.schema)
                .id()
                .field(sample.$name.key, .string, .required)
                .field(sample.$number.key, .uint, .required)
                .field(sample.$repository.$id.key, .uuid, .required, .references(TutHubRepositoryModel.schema, TutHubRepositoryModel().$id.key, onDelete: .cascade))
                .field(sample.$createdAt.$timestamp.key, .date, .required)
                .field(sample.$updatedAt.$timestamp.key, .date, .required)
                .create()
        }
        
        func revert(on database: FluentKit.Database) async throws {
            try await database.schema(TagModel.schema).delete()
        }
    }
}
