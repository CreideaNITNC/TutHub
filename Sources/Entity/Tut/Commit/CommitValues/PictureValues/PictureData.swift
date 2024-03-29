import Foundation

public struct PictureData: Hashable, Equatable {
    
    public var value: Data
    
    public init(_ data: Data) throws {
        guard Self.isValid(data) else {
            throw PictureDataError()
        }
        
        self.value = data
    }
    
    private static func isValid(_ data: Data) -> Bool {
        data.count <= MAX_BYTE_SIZE
    }
    
    private static let MAX_BYTE_SIZE = 10_000_000 /* 10MB */
    
}

fileprivate struct PictureDataError: Error {}
