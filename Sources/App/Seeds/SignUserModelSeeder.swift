import Vapor
import Fluent

extension SignUserModel {
    struct Seeder: Seedable {
        
        var signUserModels: [String: SignUserModel] = [:]
        
        init(hasher: PasswordHasher, userModelSeeder: UserModel.Seeder) throws {
            signUserModels = [
                "Takeda": .init(
                    id: UUID(),
                    mailAddress: "takeda@gmail.com",
                    passwordHash: try hasher.hash("123@takeda"),
                    userModelID: userModelSeeder.userModels["Takeda"]!.id!
                ),
                "Tanaka": .init(
                    id: UUID(),
                    mailAddress: "tanaka@icloud.com",
                    passwordHash: try hasher.hash("456@tanaka"),
                    userModelID: userModelSeeder.userModels["Tanaka"]!.id!
                ),
                "Nakata": .init(
                    id: UUID(),
                    mailAddress: "nakata@yahoo.co.jp",
                    passwordHash: try hasher.hash("789@nakata"),
                    userModelID: userModelSeeder.userModels["Nakata"]!.id!
                ),
            ]
        }
        
        func seed(_ db: Database) async throws {
            try await signUserModels.values.create(on: db)
        }
        
        func revert(_ db: Database) async throws {
            try await SignUserModel.query(on: db).delete()
        }
    }
}
