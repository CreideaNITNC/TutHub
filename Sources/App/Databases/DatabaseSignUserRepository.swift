import Vapor
import Fluent

struct DatabaseSignUserRepository: SignUserRepository {
    
    var db: Database
    
    func find(_ name: Username) async throws -> SignUser? {
        try await SignUserModel.query(on: db)
            .join(UserModel.self, on: \UserModel.$id == \SignUserModel.$userModel.$id)
            .filter(UserModel.self, \.$name == name.value)
            .first()
            .map { model in
                try .init(
                    id: .init(value: model.$userModel.id),
                    username: name,
                    mailAddress: .init(model.mailAddress),
                    passwordHash: .init(value: model.passwordHash)
                )
            }
    }
    
    func find(_ mail: MailAddress) async throws -> SignUser? {
        try await SignUserModel.query(on: db)
            .filter(\.$mailAddress == mail.value)
            .with(\.$userModel)
            .first()
            .map { signUserModel in
                try .init(
                    id: .init(value: signUserModel.$userModel.id),
                    username: .init(signUserModel.userModel.name),
                    mailAddress: .init(signUserModel.mailAddress),
                    passwordHash: .init(value: signUserModel.passwordHash)
                )
            }
    }
    
    func isMailOrNameExits(_ name: Username, _ mail: MailAddress) async throws -> Bool {
        try await SignUserModel.query(on: db)
            .join(UserModel.self, on: \UserModel.$id == \SignUserModel.$userModel.$id)
            .group(.or) { group in
                group.filter(UserModel.self, \.$name == name.value)
                    .filter(\.$mailAddress == mail.value)
            }
            .first() != nil
    }
    
    func create(_ name: Username, _ mailAddress: MailAddress, _ passwordHash: UserPasswordHash) async throws -> SignUser {
        let userModel = UserModel(name: name.value)
        try await db.transaction { transaction in
            try await userModel.create(on: transaction)
            let signUserModel = try SignUserModel(
                mailAddress: mailAddress.value,
                passwordHash: passwordHash.value,
                userModelID: userModel.requireID()
            )
            try await signUserModel.create(on: transaction)
        }
        return try .init(
            id: .init(value: userModel.requireID()),
            username: name,
            mailAddress: mailAddress,
            passwordHash: passwordHash
        )
    }
}
