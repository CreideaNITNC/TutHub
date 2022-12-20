import Vapor

struct SignInUserContent: Content {
    
    var mailAddress: String
    
    var password: String
    
}
