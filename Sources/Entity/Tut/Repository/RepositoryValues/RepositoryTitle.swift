import Foundation

public struct RepositoryTitle: Hashable, Equatable {
    public var value: String
    
    public init(_ title: String) throws {
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

fileprivate struct RepositoryTitleError: Error {
    var candidate: String
}
