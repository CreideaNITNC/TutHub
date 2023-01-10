import Vapor


struct MailAddress: Hashable, Equatable {
    
    var value: String
    
    init(_ mailAddress: String) throws {
        guard Self.isValid(mailAddress) else {
            throw MailAddressError(candidate: mailAddress)
        }
        self.value = mailAddress
    }
    
    private static func isValid(_ mail: String) -> Bool {
        let pattern = "^[a-zA-Z0-9_.+-]+@([a-zA-Z0-9][a-zA-Z0-9-]*[a-zA-Z0-9]*\\.)+[a-zA-Z]{2,}$"
        guard let regex = try? NSRegularExpression(pattern: pattern) else { return false }
        let checkingResults = regex.matches(in: mail, range: NSRange(location: 0, length: mail.count))
        return checkingResults.count > 0
    }
}

fileprivate struct MailAddressError: AbortError, DebuggableError {
    
    var candidate: String
    
    let status: HTTPStatus = .badRequest
        
    var reason: String {
        "メールアドレス: \(candidate) は不正値です"
    }
    
}
