import Vapor

extension Request {
    var signUserRepository: SignUserRepository {
        DatabaseSignUserRepository(db: db, password: password)
    }
}
