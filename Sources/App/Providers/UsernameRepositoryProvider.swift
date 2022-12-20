import Vapor

extension Request {
    var usernameRepository: UsernameRepository {
        DatabaseUsernameRepository(db: db)
    }
}
