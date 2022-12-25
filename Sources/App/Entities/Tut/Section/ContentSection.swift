struct ContentSection: Identifiable, Hashable, Equatable {
    
    var id: SectionID
    
    var title: SectionTitle
    
    var commits: [Commit]
}
