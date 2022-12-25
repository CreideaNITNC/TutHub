import Vapor

struct TutHubPageController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let page = routes.grouped("page")
        page.get(":username", ":repository", ":page", use: index)
    }
    
    func index(req: Request) async throws -> TutorialPageData {
        let username = req.parameters.get("username")!
        let repositoryName = req.parameters.get("repository")!
        let page = req.parameters.get("page", as: Int.self)!
        
        guard let user = try await req.usernameRepository.user(username) else {
            throw Abort(.unauthorized)
        }
        
        return try await req.tutorialPageDataRepository.find(userID: user.id.value, repositoryName: repositoryName, page: page)
    }
}
