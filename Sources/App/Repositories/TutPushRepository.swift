import Vapor

protocol TutPushRepository {
    func push(_ repository: TutHubContentRepository) async throws
}

extension Request {
    var tutPushRepository: TutPushRepository {
        DatabaseTutPushRepository(db: db)
    }
}
