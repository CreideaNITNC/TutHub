import Vapor
import Fluent

struct DatabaseSignUserRepository: SignUserRepository {
    
    var db: Database
    
    var password: Request.Password
    
    func isVerify(_ user: SignUserContent) async throws -> User? {
        guard
            let candidate = try await findSignUserModel(user.mailAddress),
            try await password.async.verify(user.password, created: candidate.passwordHash)
        else {
            return nil
        }
        
        return candidate.userModel.user
    }
    
    func signUp(_ user: SignUserContent) async throws -> User {
        guard try await isAlreadyExistMailAddress(user.mailAddress) else {
            throw Abort(.badRequest, reason: "the mail address is already registered")
        }
        
        let userModel = try await createUserModelAndSignUserModel(by: user)
        return userModel.user
    }
    
    
    private func isAlreadyExistMailAddress(_ mailAddress: String) async throws -> Bool {
        try await findSignUserModel(mailAddress) != nil
    }
    
    private func findSignUserModel(_ mailAddress: String) async throws -> SignUserModel? {
        try await SignUserModel.query(on: db)
            .filter(\.$mailAddress == mailAddress)
            .first()
    }
    
    private func createUserModelAndSignUserModel(by user: SignUserContent) async throws -> UserModel {
        let userModel = UserModel()
        try await userModel.create(on: db)
        
        let signUserModel = SignUserModel(
            mailAddress: user.mailAddress,
            passwordHash: try await password.async.hash(user.password),
            userModelID: try userModel.requireID()
        )
        try await userModel.$signUserModel.create(signUserModel, on: db)
        
        return userModel
    }
}
