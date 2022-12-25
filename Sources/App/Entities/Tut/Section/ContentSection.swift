struct ContentSection: Identifiable, Hashable, Equatable {
    
    var id: SectionID
    
    var commits: [Commit]
}
