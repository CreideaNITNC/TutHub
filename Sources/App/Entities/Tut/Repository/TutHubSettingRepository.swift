struct TutHubSettingRepository: Identifiable, Hashable, Equatable {
    
    var id: RepositoryID
    
    var name: RepositoryName
    
    var title: RepositoryTitle
    
    func remoteURL(_ username: Username) -> String {
        "https://tuthub-api.top/tut/\(username.value)/\(name.value)"
    }
    
    func webURL(_ username: Username) -> String {
        "https://tuthub-page.com/\(username.value)/\(name.value)/1"
    }
}
