import Vapor

struct RepositoryTitle: Hashable, Equatable {
    var value: String
    
    init(_ title: String) throws {
        guard Self.isValid(title) else {
            throw RepositoryTitleError(candidate: title)
        }
        value = title
    }
    
    private static func isValid(_ title: String) -> Bool {
        title.count <= MAX_CHAR_COUNT
    }
    
    private static let MAX_CHAR_COUNT = 100
    
}

fileprivate struct RepositoryTitleError: AbortError, DebuggableError {
    
    var candidate: String
    
    let status: HTTPStatus = .badRequest
        
    var reason: String {
        "リポジトリのタイトル: \(candidate) は不正値です"
    }
    
}
