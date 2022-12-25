import Vapor

protocol PushService {
    func push(_ user: User, _ repositoryName: RepositoryName, _ data: PushData) async throws
}

fileprivate struct PushServiceImpl: PushService {
    
    var tutPushRepository: TutPushRepository
    var tutHubSettingRepositoryRepository: TutHubSettingRepositoryRepository
    
    func push(_ user: User, _ repositoryName: RepositoryName, _ data: PushData) async throws {
        guard let repository = try await tutHubSettingRepositoryRepository.find(user.id, repositoryName) else {
            throw Abort(.badRequest, reason: "ユーザ名が取得できませんでした")
        }
        try await tutPushRepository.push(data.contentRepository(repository.id))
    }
    
}

extension Request {
    var pushService: PushService {
        PushServiceImpl(
            tutPushRepository: tutPushRepository,
            tutHubSettingRepositoryRepository: tutHubSettingRepositoryRepository
        )
    }
}
