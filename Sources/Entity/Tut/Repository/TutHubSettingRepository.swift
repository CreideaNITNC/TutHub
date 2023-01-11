public struct TutHubSettingRepository: Identifiable, Hashable, Equatable {
    
    public var id: RepositoryID
    
    public var name: RepositoryName
    
    public var title: RepositoryTitle
    
    public init(id: RepositoryID, name: RepositoryName, title: RepositoryTitle) {
        self.id = id
        self.name = name
        self.title = title
    }
    
    public func remoteURL(_ username: Username) -> String {
        "https://tuthub-api.top/tut/\(username.value)/\(name.value)"
    }
    
    public func webURL(_ username: Username) -> String {
        "https://tuthub-page.com/\(username.value)/\(name.value)/1"
    }
}
