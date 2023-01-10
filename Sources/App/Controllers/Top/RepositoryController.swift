import Vapor
import Fluent

struct RepositoryController: RouteCollection {
    
    func boot(routes: RoutesBuilder) throws {
        let repository = routes.grouped("top", "repository")
            .grouped(UserBearerAuthenticator())
            .grouped(User.guardMiddleware())
        
        repository.get(use: index)
        repository.post(use: create)
        repository.delete(":repositoryName", use: delete)
    }
    
    func index(req: Request) async throws -> RepositoriesContent {
        let user = try req.auth.require(User.self)
        guard let username = try await req.usernameRepository.find(user.id) else {
            print("❎USER ID \(user.id.value)")
            throw Abort(.internalServerError, reason: "ユーザ名が見つかりません")
        }
        let repositories = try await req.repositoryListService.read(user)
        return .init(repositories: repositories.map { repository in
                .init(
                    name: repository.name.value,
                    title: repository.title.value,
                    remoteURL: repository.remoteURL(username),
                    webURL: repository.webURL(username)
                )
        })
    }
    
    func create(req: Request) async throws -> HTTPStatus {
        let create = try req.content.decode(CreateRepositoryContent.self)
        let user = try req.auth.require(User.self)
        try await req.repositoryListService.append(user, create.getName, create.getTitle)
        return .created
    }
    
    func delete(req: Request) async throws -> HTTPStatus {
        guard let reposiotryName = try req.parameters.get("repositoryName").map(RepositoryName.init) else {
            throw Abort(.badRequest)
        }
        let user = try req.auth.require(User.self)
        try await req.repositoryListService.remove(user, reposiotryName)
        return .ok
    }
}
