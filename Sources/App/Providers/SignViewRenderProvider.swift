import Vapor

extension Request {
    var signViewRender: SignViewRenderable {
        SignViewRender(renderer: view)
    }
}
