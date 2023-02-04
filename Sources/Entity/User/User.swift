public struct User: Hashable, Equatable, Identifiable {
    
    public var id: UserID
    
    public init(id: UserID) {
        self.id = id
    }
}
