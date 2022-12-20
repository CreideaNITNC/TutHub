import Fluent

extension UserModel {
    struct Migration: AsyncMigration {
        func prepare(on database: Database) async throws {
            let sample = UserModel()
            try await database.schema(UserModel.schema)
                .id()
                .field(sample.$name.key, .string, .required)
                .field(sample.$createdAt.$timestamp.key, .datetime, .required)
                .field(sample.$updatedAt.$timestamp.key, .datetime, .required)
                .unique(on: sample.$name.key)
                .create()
        }
        
        func revert(on database: Database) async throws {
            try await database.schema(UserModel.schema).delete()
        }
    }
}
