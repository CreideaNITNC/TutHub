import Vapor
import Fluent

extension TutHubRepositoryModel {
    struct Migration: AsyncMigration {
        func prepare(on database: Database) async throws {
            let sample = TutHubRepositoryModel()
            try await database.schema(TutHubRepositoryModel.schema)
                .id()
                .field(sample.$name.key, .string, .required)
                .field(sample.$user.$id.key, .uuid, .required, .references(UserModel.schema, UserModel().$id.key, onDelete: .cascade))
                .field(sample.$createdAt.$timestamp.key, .datetime, .required)
                .field(sample.$updatedAt.$timestamp.key, .datetime, .required)
                .unique(on: sample.$name.key, sample.$user.$id.key)
                .create()
        }
        
        func revert(on database: FluentKit.Database) async throws {
            try await database.schema(TutHubRepositoryModel.schema).delete()
        }
    }
}
