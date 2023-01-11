import Foundation

struct RepositoryName: Hashable, Equatable {
    
    var value: String
    
    init(_ name: String) throws {
        guard Self.isValid(name) else {
            throw RepositoryNameError(candidate: name)
        }
        
        value = name
    }
    
    private static func isValid(_ name: String) -> Bool {
        let pattern = "[a-zA-Z0-0\\-]+"
        guard let regex = try? NSRegularExpression(pattern: pattern) else { return false }
        let checkingResults = regex.matches(in: name, range: NSRange(location: 0, length: name.count))
        return checkingResults.count > 0
    }
}

fileprivate struct RepositoryNameError: Error {
    var candidate: String
}
