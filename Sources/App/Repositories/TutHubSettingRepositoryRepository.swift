import Vapor

protocol TutHubSettingRepositoryRepository {
    
    func find(_ userID: UserID, _ repositoryName: RepositoryName) async throws -> TutHubSettingRepository?
    
    func all(_ userID: UserID) async throws -> [TutHubSettingRepository]
    
    func create(_ userID: UserID, _ repositoryName: RepositoryName, _ title: RepositoryTitle) async throws -> TutHubSettingRepository
    
    func remove(_ userID: UserID, _ repositoryName: RepositoryName) async throws
}

extension Request {
    var tutHubSettingRepositoryRepository: DatabaseTutHubSettingRepositoryRepository {
        DatabaseTutHubSettingRepositoryRepository(db: db)
    }
}

