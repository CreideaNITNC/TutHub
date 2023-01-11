import Foundation

public struct SourceCodeID: Hashable, Equatable {
    
    public var value: UUID
    
    public init(value: UUID) {
        self.value = value
    }
    
}
