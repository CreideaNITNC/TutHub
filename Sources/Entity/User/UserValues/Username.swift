import Foundation

public struct Username: Hashable, Equatable {
    
    public var value: String
    
    public init(_ name: String) throws {
        guard Self.isValid(name) else {
            throw UsernameError(candidate: name)
        }
        
        self.value = name
    }
    
    private static func isValid(_ name: String) -> Bool {
        let pattern = "^[a-zA-Z0-9-]+$"
        guard let regex = try? NSRegularExpression(pattern: pattern) else { return false }
        let checkingResults = regex.matches(in: name, range: NSRange(location: 0, length: name.count))
        return checkingResults.count > 0
    }
}

fileprivate struct UsernameError: Error {
    var candidate: String
}
