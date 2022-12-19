//import Vapor
//
//struct TutHubRepository {
//    var id: UUID
//    var name: String
//    var user: User
//    
//    @ID(key: "id")
//    var id: UUID?
//    
//    @Field(key: "name")
//    var name: String
//    
//    @Parent(key: "user_id")
//    var user: UserModel
//    
//    @Children(for: \.$repository)
//    var tags: [SectionModel]
//    
//    @Timestamp(key: "created_at", on: .create)
//    var createdAt: Date?
//    
//    @Timestamp(key: "updated_at", on: .update)
//    var updatedAt: Date?
//}
