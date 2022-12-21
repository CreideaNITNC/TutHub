import Vapor
import Fluent

struct DatabaseSignUserRepository: SignUserRepository {
    
    var db: Database
    
    var password: AsyncPasswordHasher
    
    func verify(_ user: SignInUserContent) async throws -> User? {
        guard
            let candidate = try await findSignUserModel(user.mailAddress),
            try await password.verify(user.password, created: candidate.passwordHash)
        else {
            return nil
        }
        try await candidate.$userModel.load(on: db)
        return candidate.userModel.user
    }
    
    func signUp(_ user: SignUpUserContent) async throws -> User {
        guard !(try await isAlreadyExistMailAddress(user.mailAddress)) else {
            throw Abort(.badRequest, reason: "the mail address is already registered")
        }
        guard !(try await isAlreadyExistName(user.name)) else {
            throw Abort(.badRequest, reason: "the name is already registered")
        }
        
        let userModel = try await createUserModelAndSignUserModel(by: user)
        return userModel.user
    }
    
    
    private func isAlreadyExistMailAddress(_ mailAddress: String) async throws -> Bool {
        try await findSignUserModel(mailAddress) != nil
    }
    
    private func isAlreadyExistName(_ name: String) async throws -> Bool {
        try await UserModel.query(on: db).filter(\.$name == name).first() != nil
    }
    
    private func findSignUserModel(_ mailAddress: String) async throws -> SignUserModel? {
        try await SignUserModel.query(on: db)
            .filter(\.$mailAddress == mailAddress)
            .first()
    }
    
    private func createUserModelAndSignUserModel(by user: SignUpUserContent) async throws -> UserModel {
        let userModel = UserModel(name: user.name)
        let passwordHash = try await password.hash(user.password)
        
        try await db.transaction { transaction in
            try await userModel.create(on: transaction)
            
            let signUserModel = SignUserModel(
                mailAddress: user.mailAddress,
                passwordHash: passwordHash,
                userModelID: try userModel.requireID()
            )
            try await userModel.$signUserModel.create(signUserModel, on: transaction)
        }
        
        return userModel
    }
}
