import Vapor
import Leaf

protocol SignViewRenderable {
    func render(isFailed: Bool, isAlreadyRegistered: Bool) async throws -> View
}

struct SignViewRender: SignViewRenderable {
    static let leaf = "sign"
    
    var renderer: ViewRenderer
    
    func render(isFailed: Bool, isAlreadyRegistered: Bool) async throws -> View {
        try await renderer.render(Self.leaf, [
            "isFailed": isFailed,
            "isAlreadyRegistered": isAlreadyRegistered,
        ])
    }
}
