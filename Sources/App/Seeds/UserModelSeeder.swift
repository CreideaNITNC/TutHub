import Vapor
import Fluent

extension UserModel {
    
    struct Seeder: Seedable {
        
        var userModels: [String: UserModel] = [
            "Takeda": .init(id: UUID(), name: "Takeda"),
            "Tanaka": .init(id: UUID(), name: "Tanaka"),
            "Nakata": .init(id: UUID(), name: "nakata"),
        ]
        
        func seed(_ db: Database) async throws {
            try await userModels.values.create(on: db)
        }
        
        func revert(_ db: Database) async throws {
            try await UserModel.query(on: db).delete()
        }
    }
}
