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
        let regex = "[a-zA-Z0-9-]+"
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: name)
    }
}

fileprivate struct UsernameError: AbortError, DebuggableError {
    
    var candidate: String
    
    let status: HTTPStatus = .badRequest
        
    var reason: String {
        "ユーザ名: \(candidate) は不正値です"
    }
    
}
