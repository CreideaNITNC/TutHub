import Vapor

protocol TutPushRepository {
    func push(userID: UUID, repositoryName: String, data: PushData) async throws
}
