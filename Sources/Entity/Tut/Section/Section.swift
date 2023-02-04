public struct Section: Identifiable, Hashable, Equatable {
    
    public var id: SectionID
    
    public init(id: SectionID) {
        self.id = id
    }
}
