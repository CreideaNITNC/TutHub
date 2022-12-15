import Vapor

struct TutHubPageController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let page = routes.grouped("page")
        page.get(":userID", ":repository", ":page", use: index)
    }
    
    func index(req: Request) async throws -> TutorialPageData {
        let userID = req.parameters.get("userID", as: UUID.self)!
        let repositoryName = req.parameters.get("repository")!
        let page = req.parameters.get("page", as: Int.self)!
        
        return try await req.tutorialPageDataRepository.find(userID: userID, repositoryName: repositoryName, page: page)
    }
}
