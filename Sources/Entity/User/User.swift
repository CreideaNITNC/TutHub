public struct User: Equatable, Hashable, Identifiable {
    
    public var id: UserID
    
    public init(id: UserID) {
        self.id = id
    }
}
