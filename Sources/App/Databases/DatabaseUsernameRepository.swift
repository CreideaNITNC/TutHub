import Vapor
import Fluent

struct DatabaseUsernameRepository: UsernameRepository {
    
    var db: Database
    
    func user(_ username: String) async throws -> User? {
        try await UserModel.query(on: db)
            .filter(\.$name == username)
            .first()?
            .user
    }
    

    func find(_ user: User) async throws -> String? {
        try await UserModel.find(user.id.value, on: db)?.name
    }
    
}
