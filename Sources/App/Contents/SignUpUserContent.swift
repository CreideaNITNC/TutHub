import Vapor

struct SignUpUserContent: Content {
    
    var mailAddress: String
    
    var name: String
    
    var password: String
    
}
