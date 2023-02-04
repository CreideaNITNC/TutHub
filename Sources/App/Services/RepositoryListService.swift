import Vapor
import Entity

protocol RepositoryListService {
    
    func append(_ user: User, _ repositoryName: RepositoryName, _ title: RepositoryTitle) async throws
    
    func read(_ user: User) async throws -> [TutHubSettingRepository]
    
    func remove(_ user: User, _ repositoryName: RepositoryName) async throws
}

fileprivate struct RepositoryListServiceImpl: RepositoryListService {
    
    func append(_ user: User, _ repositoryName: RepositoryName, _ title: RepositoryTitle) async throws {
        try await settingRepositoryRepository.create(user.id, repositoryName, title)
    }
    
    var settingRepositoryRepository: TutHubSettingRepositoryRepository
    
    func read(_ user: User) async throws -> [TutHubSettingRepository] {
        try await settingRepositoryRepository.all(user.id)
    }
    
    func remove(_ user: User, _ repositoryName: RepositoryName) async throws {
        try await settingRepositoryRepository.remove(user.id, repositoryName)
    }
}

extension Request {
    var repositoryListService: RepositoryListService {
        RepositoryListServiceImpl(settingRepositoryRepository: tutHubSettingRepositoryRepository)
    }
}
