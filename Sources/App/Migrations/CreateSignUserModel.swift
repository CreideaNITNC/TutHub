import Fluent

extension SignUserModel {
    struct Migration: AsyncMigration {
        
        func prepare(on database: Database) async throws {
            let sample = SignUserModel()
            try await database.schema(SignUserModel.schema)
                .id()
                .field(sample.$mailAddress.key, .string, .required)
                .field(sample.$passwordHash.key, .string, .required)
                .field(sample.$userModel.$id.key, .uuid, .required, .references(UserModel.schema, UserModel().$id.key))
                .unique(on: sample.$mailAddress.key)
                .create()
        }
        
        func revert(on database: Database) async throws {
            try await database.schema(SignUserModel.schema).delete()
        }
        
    }
}
