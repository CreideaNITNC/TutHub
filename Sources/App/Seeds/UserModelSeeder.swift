import Vapor
import Fluent

extension UserModel {
    
    struct Seeder: Seedable {
        
        var userModels: [String: UserModel] = [
            "Takeda": .init(id: UUID()),
            "Tanaka": .init(id: UUID()),
            "Nakata": .init(id: UUID()),
        ]
        
        func seed(_ db: Database) async throws {
            try await userModels.values.create(on: db)
        }
        
        func revert(_ db: Database) async throws {
            try await UserModel.query(on: db).delete()
        }
    }
}
