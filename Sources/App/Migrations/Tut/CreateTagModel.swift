import Vapor
import Fluent

extension SectionModel {
    struct Migration: AsyncMigration {
        func prepare(on database: Database) async throws {
            let sample = SectionModel()
            try await database.schema(SectionModel.schema)
                .id()
                .field(sample.$name.key, .string, .required)
                .field(sample.$number.key, .uint, .required)
                .field(sample.$repository.$id.key, .uuid, .required, .references(TutHubRepositoryModel.schema, TutHubRepositoryModel().$id.key, onDelete: .cascade))
                .field(sample.$createdAt.$timestamp.key, .datetime, .required)
                .field(sample.$updatedAt.$timestamp.key, .datetime, .required)
                .create()
        }
        
        func revert(on database: FluentKit.Database) async throws {
            try await database.schema(SectionModel.schema).delete()
        }
    }
}
