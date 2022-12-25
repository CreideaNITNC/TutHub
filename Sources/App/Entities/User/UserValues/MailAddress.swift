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
        let regex = "^[a-zA-Z0-9_.+-]+@([a-zA-Z0-9][a-zA-Z0-9-]*[a-zA-Z0-9]*\\.)+[a-zA-Z]{2,}$"
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: mail)
        
    }
}

fileprivate struct MailAddressError: AbortError, DebuggableError {
    
    var candidate: String
    
    let status: HTTPStatus = .badRequest
        
    var reason: String {
        "メールアドレス: \(candidate) は不正値です"
    }
    
}
