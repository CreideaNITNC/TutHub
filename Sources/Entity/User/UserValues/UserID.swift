import Foundation

public struct UserID: Hashable, Equatable {
    
    public var value: UUID
    
    public init(value: UUID) {
        self.value = value
    }
}
