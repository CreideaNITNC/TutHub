import Vapor

struct MailAddressSignInUserContent: Content {
    
    var mailAddress: String
    
    var password: String
    
    func getMailAddress() throws -> MailAddress {
        try .init(mailAddress)
    }
}
