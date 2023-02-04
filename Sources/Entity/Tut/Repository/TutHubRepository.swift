public struct TutHubRepository: Identifiable, Hashable, Equatable {
    
    public var id: RepositoryID
    
    public init(id: RepositoryID) {
        self.id = id
    }
}
