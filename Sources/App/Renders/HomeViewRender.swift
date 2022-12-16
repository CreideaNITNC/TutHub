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
    
    func render() async throws -> View {
        try await renderer.render(Self.leaf, try await repositories())
    }
    
    private func repositories() async throws -> RepositoriesContent {
        .init(
            repositories: try await TutHubRepositoryModel.query(on: db)
                .filter(\.$user.$id == user.id)
                .all()
                .map { .init(name: $0.name, link: "/\(user.id)/\($0.name)")}
        )
    }
}
