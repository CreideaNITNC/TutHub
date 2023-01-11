import Vapor
import Entity

protocol SignService {
    func signIn(_ user: MailAddressSignInUserContent) async throws -> User?
    func signIn(_ user: UsernameSignInUserContent) async throws -> User?
    func signUp(_ user: SignUpUserContent) async throws -> User?
}

fileprivate struct SignServiceImpl: SignService {
    
    var signUserRepository: SignUserRepository
    var hasher: AsyncPasswordHasher
    
    func signIn(_ user: MailAddressSignInUserContent) async throws -> User? {
        guard
            let signUser = try await signUserRepository.find(user.getMailAddress),
            try await hasher.verify(user.password, created: signUser.passwordHash.value)
        else {
            return nil
        }
        return signUser.user
    }
    
    func signIn(_ user: UsernameSignInUserContent) async throws -> User? {
        guard
            let signUser = try await signUserRepository.find(user.getUsername),
            try await hasher.verify(user.password, created: signUser.passwordHash.value)
        else {
            return nil
        }
        return signUser.user
    }
    
    func signUp(_ user: SignUpUserContent) async throws -> User? {
        let username = try user.getUsername
        let mail = try user.getMailAddress
        
        if try await signUserRepository.isMailOrNameExits(username, mail) {
            return nil
        }
        
        let passwordHash = try await UserPasswordHash(value: hasher.hash(user.password))
        let signUser = try await signUserRepository.create(
            user.getUsername,
            user.getMailAddress,
            passwordHash
        )
        return .init(id: signUser.id)
    }
    
}

extension Request {
    var signService: SignService {
        SignServiceImpl(
            signUserRepository: signUserRepository,
            hasher: password.async
        )
    }
}
