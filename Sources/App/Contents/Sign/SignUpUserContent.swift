import Vapor

struct SignUpUserContent: Content {
    
    var mailAddress: String
    
    var name: String
    
    var password: String
    
    func getMailAddress() throws -> MailAddress {
        try .init(mailAddress)
    }
    
    func getUsername() throws -> Username {
        try .init(name)
    }
}
