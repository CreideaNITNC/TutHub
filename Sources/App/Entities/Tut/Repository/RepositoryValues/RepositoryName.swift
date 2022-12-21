import Vapor


struct RepositoryName: Hashable, Equatable {
    
    var value: String
    
    init(_ name: String) throws {
        guard Self.isValid(name) else {
            throw RepositoryNameError(candidate: name)
        }
        
        value = name
    }
    
    private static func isValid(_ name: String) -> Bool {
        let regex = "[a-zA-Z0-0\\-]+"
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: name)
    }
}

fileprivate struct RepositoryNameError: AbortError, DebuggableError {
    
    var candidate: String
    
    let status: HTTPStatus = .badRequest
        
    var reason: String {
        "リポジトリ名: \(candidate) は不正値です"
    }
    
}
