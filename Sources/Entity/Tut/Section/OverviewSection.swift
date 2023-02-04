public struct OverviewSection: Identifiable, Hashable, Equatable {
    
    public var id: SectionID
    
    public var title: SectionTitle
    
    public init(id: SectionID, title: SectionTitle) {
        self.id = id
        self.title = title
    }
    
}
