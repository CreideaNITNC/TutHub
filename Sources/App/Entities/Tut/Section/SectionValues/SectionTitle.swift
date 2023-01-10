import Vapor

struct SectionTitle: Hashable, Equatable {
    
    var value: String
    
    init(_ title: String) throws {
        guard Self.isValid(title) else {
            throw SectionTitleError(candidate: title)
        }
        
        value = title
    }
    
    private static func isValid(_ title: String) -> Bool {
        !title.isEmpty && title.count <= 20
    }
     
    private static let MAX_TITLE_COUNT = 20
}

fileprivate struct SectionTitleError: AbortError, DebuggableError {
    
    var candidate: String
    
    let status: HTTPStatus = .badRequest
        
    var reason: String {
        "セクションのタイトル: \(candidate) は不正値です"
    }
    
}
