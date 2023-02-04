public struct UserPasswordHash: Hashable, Equatable {
    
    public var value: String
    
    public init(value: String) {
        self.value = value
    }
}
