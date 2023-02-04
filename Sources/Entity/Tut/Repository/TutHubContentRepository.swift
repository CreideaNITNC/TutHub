public struct TutHubContentRepository: Identifiable, Hashable, Equatable {
    
    public var id: RepositoryID
    
    public var sections: [ContentSection]
    
    public init(id: RepositoryID, sections: [ContentSection]) {
        self.id = id
        self.sections = sections
    }
    
}
