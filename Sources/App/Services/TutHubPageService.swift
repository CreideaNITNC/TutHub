import Vapor
import Entity

protocol TutHubPageService {
    func read(_ username: Username, _ repositoryName: RepositoryName, _ page: SectionPage) async throws -> ContentSection
}

fileprivate struct TutHubPageServiceImpl: TutHubPageService {
    
    var usernameRepository: UsernameRepository
    
    var sectionRepository: SectionRepoistory
    
    var contentSectionRepository: ContentSectionRepository
    
    func read(_ username: Username, _ repositoryName: RepositoryName, _ page: SectionPage) async throws -> ContentSection {
        guard
            let user = try await usernameRepository.user(username),
            let section = try await sectionRepository.find(user, repositoryName, page),
            let content = try await contentSectionRepository.find(section.id)
        else {
            throw Abort(.badRequest, reason: "セクションが存在しません")
        }
        return content
    }
}

extension Request {
    var tutHubPageService: TutHubPageService {
        TutHubPageServiceImpl(
            usernameRepository: usernameRepository,
            sectionRepository: sectionRepository,
            contentSectionRepository: contentSectionRepository
        )
    }
}
