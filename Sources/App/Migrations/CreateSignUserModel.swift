import Fluent

extension SignUserModel {
    struct Migration: AsyncMigration {
        
        func prepare(on database: Database) async throws {
            let sample = SignUserModel()
            try await database.schema(SignUserModel.schema)
                .id()
                .field(sample.$mailAddress.key, .string, .required)
                .field(sample.$passwordHash.key, .string, .required)
                .field(sample.$userModel.$id.key, .uuid, .required, .references(UserModel.schema, UserModel().$id.key, onDelete: .cascade))
                .field(sample.$createdAt.$timestamp.key, .datetime, .required)
                .field(sample.$updatedAt.$timestamp.key, .datetime, .required)
                .unique(on: sample.$userModel.$id.key)
                .unique(on: sample.$mailAddress.key)
                .create()
        }
        
        func revert(on database: Database) async throws {
            try await database.schema(SignUserModel.schema).delete()
        }
        
    }
}
