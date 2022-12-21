import Vapor


struct SourceText: Hashable, Equatable {
    
    var value: String
    
    init(_ text: String) throws {
        guard Self.isValid(text) else {
            throw SourceTextError(candidate: text)
        }
        
        value = text
    }
    
    private static func isValid(_ text: String) -> Bool {
        !text.isEmpty && text.count <= MAX_SOURCE_TEXT_COUNT
    }
    
    private static let MAX_SOURCE_TEXT_COUNT = 10_000
    
}

fileprivate struct SourceTextError: AbortError, DebuggableError {
    
    var candidate: String
    
    let status: HTTPStatus = .badRequest
        
    var reason: String {
        "ソースファイルのテキスト: \(candidate) は不正値です"
    }
    
}
