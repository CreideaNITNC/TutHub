import Vapor

protocol TutorialPageDataRepository {
    func find(userID: UUID, repositoryName: String, page: Int) async throws -> TutorialPageData
}
