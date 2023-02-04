import Vapor
import Entity

struct MailAddressSignInUserContent: Content {
    
    var mail: String
    
    var password: String
    
    var getMailAddress: MailAddress {
        get throws {
            try .init(mail)
        }
    }
}
