import Foundation

public struct SourceFilename: Hashable, Equatable {
    
    public var value: String
    
    public init(_ filename: String) throws {
        guard Self.isValid(filename) else {
            throw SourceFilenameError(candidate: filename)
        }
        
        value = filename
    }
    
    private static func isValid(_ filename: String) -> Bool {
        !filename.isEmpty && filename.count <= MAX_SOURCE_FILENAME_COUNT
    }
    
    private static let MAX_SOURCE_FILENAME_COUNT = 100
    
}

fileprivate struct SourceFilenameError: Error {
    var candidate: String
}
