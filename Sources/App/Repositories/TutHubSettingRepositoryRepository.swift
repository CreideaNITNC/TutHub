import Vapor

protocol TutHubSettingRepositoryRepository {
    func find(_ userID: UserID, _ repositoryName: RepositoryName) async throws -> TutHubSettingRepository?
}

extension Request {
    var tutHubSettingRepositoryRepository: DatabaseTutHubSettingRepositoryRepository {
        DatabaseTutHubSettingRepositoryRepository(db: db)
    }
}

