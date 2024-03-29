import Vapor
import Entity
import Presentation
import Repository

struct TutHubPageController: RouteCollection {
    
    var cache: TutorialPageDataCache
    
    func boot(routes: RoutesBuilder) throws {
        let page = routes.grouped("page")
        page.get(":username", ":repository", ":page", use: index)
    }
    
    func index(req: Request) async throws -> TutorialPageData {
        guard
            let username = try req.parameters.get("username").map(Username.init),
            let repositoryName = try req.parameters.get("repository").map(RepositoryName.init),
            let page = try req.parameters.get("page", as: Int.self).map(SectionPage.init),
            let user = try await req.usernameRepository.user(username),
            let repository = try await req.tutHubSettingRepositoryRepository.find(user.id, repositoryName)
        else { throw Abort(.badRequest) }
        
        if let data = await cache.find(username, repositoryName) {
            return data
        }
        
        let content = try await req.tutHubPageService.read(username, repositoryName, page)
        let data = TutorialPageData(username, repositoryName, repository.title, page, content)
        
        await cache.cache(username, repositoryName, data)
        
        return data
    }
}
