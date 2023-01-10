import Vapor

struct Username: Hashable, Equatable {
    var value: String
    
    init(_ name: String) throws {
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

fileprivate struct UsernameError: AbortError, DebuggableError {
    
    var candidate: String
    
    let status: HTTPStatus = .badRequest
    
    var reason: String {
        "ユーザ名: \(candidate) は不正値です"
    }
    
}
