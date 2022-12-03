import Vapor
import Fluent

final class UserModel: Model {
    
    static let schema = "users"
    
    @ID(key: "id")
    var id: UUID?
    
    var user: User {
        guard let id else { fatalError("required user, but id == nil") }
        return .init(id: id)
    }
    
    @OptionalChild(for: \.$userModel)
    var signUserModel: SignUserModel?
}
