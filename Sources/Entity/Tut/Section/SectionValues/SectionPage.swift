import Foundation

public struct SectionPage: Hashable, Equatable {
    public var value: Int
    
    public init(_ page: Int) throws {
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

fileprivate struct SectionPageError: Error {
    var candidate: Int
}
