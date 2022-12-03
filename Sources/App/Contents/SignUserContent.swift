import Vapor

struct SignUserContent: Content {
    
    var mailAddress: String
    
    var password: String
    
}
