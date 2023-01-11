import Vapor
import Fluent
import Entity

struct DatabaseContentSectionRepository: ContentSectionRepository {
    
    var db: Database
    
    func find(_ id: SectionID) async throws -> ContentSection? {
        try await SectionModel.query(on: db)
            .filter(\.$id == id.value)
            .with(\.$commits) { commit in
                commit.with(\.$pictures)
                commit.with(\.$codes)
            }
            .first()?
            .contentSection()
    }
}
