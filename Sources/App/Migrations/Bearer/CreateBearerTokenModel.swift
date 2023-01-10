import Vapor
import Fluent

extension BearerTokenModel {
    struct Migration: AsyncMigration {
        func prepare(on database: Database) async throws {
            let sample = BearerTokenModel()
            try await database.schema(BearerTokenModel.schema)
                .id()
                .field(sample.$userModel.$id.key, .uuid, .required)
                .field(sample.$createdAt.$timestamp.key, .datetime, .required)
                .create()
        }
        
        func revert(on database: FluentKit.Database) async throws {
            try await database.schema(BearerTokenModel.schema).delete()
        }
    }
}
