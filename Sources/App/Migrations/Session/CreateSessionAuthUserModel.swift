import Vapor
import Fluent

extension SessionAuthUserModel {
    struct Migration: AsyncMigration {
        func prepare(on database: Database) async throws {
            let sample = SessionAuthUserModel()
            try await database.schema(SessionAuthUserModel.schema)
                .id()
                .field(sample.$sessionID.key, .uuid, .required)
                .field(sample.$userID.key, .uuid, .required)
                .field(sample.$createdAt.$timestamp.key, .datetime, .required)
                .unique(on: sample.$sessionID.key)
                .create()
        }
        
        func revert(on database: FluentKit.Database) async throws {
            try await database.schema(SessionAuthUserModel.schema).delete()
        }
    }
}
