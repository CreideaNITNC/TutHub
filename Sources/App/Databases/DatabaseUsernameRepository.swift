import Vapor
import Fluent
import Entity

struct DatabaseUsernameRepository: UsernameRepository {
    
    var db: Database
    
    func user(_ username: Username) async throws -> User? {
        try await UserModel.query(on: db)
            .filter(\.$name == username.value)
            .first()
            .map { $0.user }
    }
    

    func find(_ id: UserID) async throws -> Username? {
        try await UserModel.find(id.value, on: db)
            .map { try Username($0.name) }
    }
    
}
