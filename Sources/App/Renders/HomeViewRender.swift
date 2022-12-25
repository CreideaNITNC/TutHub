import Vapor
import Leaf
import Fluent

protocol HomeViewRenderable {
    func render() async throws -> View
}

struct HomeViewRender: HomeViewRenderable {
    static let leaf = "home"
    
    var renderer: ViewRenderer
    
    var user: User
    
    var db: Database
    
    var usernameRepository: UsernameRepository
    
    func render() async throws -> View {
        try await renderer.render(Self.leaf, try await repositories())
    }
    
    private func repositories() async throws -> RepositoriesContent {
        guard let username = try await usernameRepository.find(user.id) else {
            throw Abort(.unauthorized)
        }
        return .init(
            repositories: try await TutHubRepositoryModel.query(on: db)
                .filter(\.$userModel.$id == user.id.value)
                .all()
                .map { .init(name: $0.name, link: "/\(username)/\($0.name)")}
        )
    }
}

extension Request {
    func homeViewRender()  throws -> HomeViewRenderable {
        try HomeViewRender(
            renderer: leaf,
            user: requireUser(),
            db: db,
            usernameRepository: usernameRepository
        )
    }
}
