import Vapor

struct SignUpUserContent: Content {
    
    var mail: String
    
    var name: String
    
    var password: String
    
    var getMailAddress: MailAddress {
        get throws {
            try .init(mail)
        }
    }
    
    var getUsername: Username {
        get throws {
            try .init(name)
        }
    }
}
