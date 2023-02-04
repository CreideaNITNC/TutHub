import Foundation

public struct RepositoryID: Hashable, Equatable {
    
    public var value: UUID
    
    public init(value: UUID) {
        self.value = value
    }
}
