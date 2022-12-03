import Fluent

extension UserModel {
    struct Migration: AsyncMigration {
        func prepare(on database: Database) async throws {
            try await database.schema(UserModel.schema)
                .id()
                .create()
        }
        
        func revert(on database: Database) async throws {
            try await database.schema(UserModel.schema).delete()
        }
    }
}
