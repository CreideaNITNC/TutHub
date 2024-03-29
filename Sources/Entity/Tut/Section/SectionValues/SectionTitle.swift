import Foundation

public struct SectionTitle: Hashable, Equatable {
    
    public var value: String
    
    public init(_ title: String) throws {
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

fileprivate struct SectionTitleError: Error {
    var candidate: String
}
