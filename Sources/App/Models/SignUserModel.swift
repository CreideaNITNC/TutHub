import Vapor
import Fluent

final class SignUserModel: Model {
    
    static let schema = "sign_users"
    
    @ID(key: "id")
    var id: UUID?
    
    @Field(key: "mail_address")
    var mailAddress: String
    
    @Field(key: "password_hash")
    var passwordHash: String
    
    @Parent(key: "user_id")
    var userModel: UserModel
    
    @Timestamp(key: "created_at", on: .create)
    var createdAt: Date?
    
    @Timestamp(key: "updated_at", on: .update)
    var updatedAt: Date?
    
    init() { }
    
    init(id: UUID? = nil, mailAddress: String, passwordHash: String, userModelID: UserModel.IDValue) {
        self.id = id
        self.mailAddress = mailAddress
        self.passwordHash = passwordHash
        self.$userModel.id = userModelID
    }
    
}
