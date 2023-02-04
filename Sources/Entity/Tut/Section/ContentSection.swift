public struct ContentSection: Identifiable, Hashable, Equatable {
    
    public var id: SectionID
    
    public var title: SectionTitle
    
    public var commits: [Commit]
    
    public init(id: SectionID, title: SectionTitle, commits: [Commit]) {
        self.id = id
        self.title = title
        self.commits = commits
    }
}
