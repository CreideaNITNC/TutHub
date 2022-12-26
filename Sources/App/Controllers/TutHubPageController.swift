import Vapor

struct TutHubPageController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let page = routes.grouped("page")
        page.get(":username", ":repository", ":page", use: index)
    }
    
    func index(req: Request) async throws -> TutorialPageData {
        guard
            let username = try req.parameters.get("username").map(Username.init),
            let repositoryName = try req.parameters.get("repository").map(RepositoryName.init),
            let page = try req.parameters.get("page", as: Int.self).map(SectionPage.init)
        else { throw Abort(.badRequest) }
        
        let content = try await req.tutHubPageService.read(username, repositoryName, page)
        return .init(username, repositoryName, page, content)
    }
}
