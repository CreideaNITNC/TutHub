import Foundation

struct PictureFilename: Hashable, Equatable {
    
    var value: String
    
    init(_ filename: String) throws {
        guard Self.isValid(filename) else {
            throw PictureFilenameError(candidate: filename)
        }
        
        value = filename
    }
    
    private static func isValid(_ filename: String) -> Bool {
        guard !filename.isEmpty else { return false }
        guard filename.count <= MAX_SOURCE_FILENAME_COUNT else { return false }
        guard !isPath(filename) else { return false }
        return true
    }
    
    private static let MAX_SOURCE_FILENAME_COUNT = 100

    private static func isPath(_ filename: String) -> Bool {
        filename.contains("/")
    }
    
}

fileprivate struct PictureFilenameError: Error {
    var candidate: String
}
