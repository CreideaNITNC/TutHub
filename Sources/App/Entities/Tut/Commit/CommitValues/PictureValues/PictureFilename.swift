import Vapor


struct PictureFilename: Hashable, Equatable {
    
    var value: String
    
    init(_ filename: String) throws {
        guard Self.isValid(filename) else {
            throw PictureFilenameError(candidate: filename)
        }
        
        value = filename
    }
    
    private static func isValid(_ filename: String) -> Bool {
        !filename.isEmpty && filename.count <= MAX_SOURCE_FILENAME_COUNT
    }
    
    private static let MAX_SOURCE_FILENAME_COUNT = 100
    
}

fileprivate struct PictureFilenameError: AbortError, DebuggableError {
    
    var candidate: String
    
    let status: HTTPStatus = .badRequest
        
    var reason: String {
        "画像ファイル名: \(candidate) は不正値です"
    }
    
}
