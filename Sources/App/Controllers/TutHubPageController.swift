import Vapor

struct TutHubPageController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let page = routes.grouped("page")
        page.get(":username", ":repository", ":page", use: index)
    }
    
    func index(req: Request) async throws -> TutorialPageData {
        let username = try Username(req.parameters.get("username")!)
        let repositoryName = try RepositoryName(req.parameters.get("repository")!)
        guard let page = try req.parameters.get("page", as: Int.self).map({ try SectionPage($0) }) else {
            throw Abort(.badRequest, reason: "ページ番号は数値である必要があります")
        }
        
        let content = try await req.tutHubPageService.read(username, repositoryName, page)
        return .init(username, repositoryName, page, content)
    }
}
