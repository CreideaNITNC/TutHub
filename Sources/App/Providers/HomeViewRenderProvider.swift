import Vapor

extension Request {
    var homeViewRender: HomeViewRenderable {
        guard let user = auth.get(User.self) else {
            fatalError("used HomeViewRender, but user didn't login")
        }
        return HomeViewRender(renderer: view, user: user, db: db)
    }
}
