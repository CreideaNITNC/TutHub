import Vapor

struct SectionPage: Hashable, Equatable {
    var value: Int
    
    init(_ page: Int) throws {
        guard Self.isValid(page) else {
            throw SectionPageError(candidate: page)
        }
        self.value = page
    }
    
    private static func isValid(_ page: Int) -> Bool {
        page >= MIN_PAGE_NUMBER
    }
    
    private static let MIN_PAGE_NUMBER = 1
}

fileprivate struct SectionPageError: AbortError, DebuggableError {
    
    var candidate: Int
    
    let status: HTTPStatus = .badRequest
        
    var reason: String {
        "セクションのページ: \(candidate) は不正値です"
    }
    
}
