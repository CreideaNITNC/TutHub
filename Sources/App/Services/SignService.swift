import Vapor

protocol SignService {
    func signIn(_ user: MailAddressSignInUserContent) async throws -> Bool
    func signIn(_ user: UsernameSignInUserContent) async throws -> Bool
    func signUp(_ user: SignUpUserContent) async throws -> User?
}

fileprivate struct SignServiceImpl: SignService {
    
    var signUserRepository: SignUserRepository
    var hasher: AsyncPasswordHasher
    
    func signIn(_ user: MailAddressSignInUserContent) async throws -> Bool {
        guard let signUser = try await signUserRepository.find(user.getMailAddress()) else {
            return false
        }
        return try await hasher.verify(user.password, created: signUser.passwordHash.value)
    }
    
    func signIn(_ user: UsernameSignInUserContent) async throws -> Bool {
        guard let signUser = try await signUserRepository.find(user.getUsername()) else {
            return false
        }
        return try await hasher.verify(user.password, created: signUser.passwordHash.value)
    }
    
    func signUp(_ user: SignUpUserContent) async throws -> User? {
        let username = try user.getUsername()
        let mail = try user.getMailAddress()
        
        if try await signUserRepository.isMailOrNameExits(username, mail) {
            return nil
        }
        
        let passwordHash = try await UserPasswordHash(value: hasher.hash(user.password))
        let signUser = try await signUserRepository.create(
            user.getUsername(),
            user.getMailAddress(),
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
