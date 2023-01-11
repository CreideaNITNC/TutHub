import Foundation

struct CommitMessage: Hashable, Equatable {
    
    var value: String
    
    init(_ message: String) throws {
        guard Self.isValid(message) else {
            throw CommitMessageError(candidate: message)
        }
        
        value = message
    }
    
    private static func isValid(_ message: String) -> Bool {
        message.count <= MAX_MESSAGE_COUNT
    }
    
    private static let MAX_MESSAGE_COUNT = 10_000
    
}

fileprivate struct CommitMessageError: Error {
    var candidate: String
}
