import Vapor
import Entity
import Presentation

protocol PushService {
    func push(_ user: User, _ username: Username, _ repositoryName: RepositoryName, _ data: PushData) async throws
}

fileprivate struct PushServiceImpl: PushService {
    
    var usernameRepository: UsernameRepository
    var tutPushRepository: TutPushRepository
    var tutHubSettingRepositoryRepository: TutHubSettingRepositoryRepository
    
    func push(_ user: User, _ username: Username, _ repositoryName: RepositoryName, _ data: PushData) async throws {
        guard try await usernameRepository.find(user.id) == username else {
            throw Abort(.unauthorized, reason: "このリポジトリの操作権限はありません")
        }
        
        guard let repository = try await tutHubSettingRepositoryRepository.find(user.id, repositoryName) else {
            throw Abort(.badRequest, reason: "リポジトリ名が取得できませんでした")
        }
        try await tutPushRepository.push(data.contentRepository(repository.id))
    }
    
}

extension Request {
    var pushService: PushService {
        PushServiceImpl(
            usernameRepository: usernameRepository,
            tutPushRepository: tutPushRepository,
            tutHubSettingRepositoryRepository: tutHubSettingRepositoryRepository
        )
    }
}
