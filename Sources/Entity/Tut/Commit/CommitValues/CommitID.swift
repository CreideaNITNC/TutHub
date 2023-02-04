import Foundation

public struct CommitID: Hashable, Equatable {
    
    public var value: UUID
    
    public init(value: UUID) {
        self.value = value
    }
}
