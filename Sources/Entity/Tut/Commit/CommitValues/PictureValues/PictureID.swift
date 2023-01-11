import Foundation

public struct PictureID: Hashable, Equatable {
    
    public var value: UUID
    
    public init(value: UUID) {
        self.value = value
    }
    
}
