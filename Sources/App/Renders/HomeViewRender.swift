import Vapor
import Leaf

protocol HomeViewRenderable {
    func render() async throws -> View
}

struct HomeViewRender: HomeViewRenderable {
    static let leaf = "home"
    
    var renderer: ViewRenderer
    
    var user: User
    
    func render() async throws -> View {
        try await renderer.render(Self.leaf, ["id": user.id])
    }
}
