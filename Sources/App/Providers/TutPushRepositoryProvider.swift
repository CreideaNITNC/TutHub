import Vapor

extension Request {
    var tutPushRepository: TutPushRepository {
        DatabaseTutPushRepository(db: db)
    }
}
