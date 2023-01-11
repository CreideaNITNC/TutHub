import Vapor
import Entity

protocol ContentSectionRepository {
    func find(_ sectionID: SectionID) async throws -> ContentSection?
}

extension Request {
    var contentSectionRepository: ContentSectionRepository {
        DatabaseContentSectionRepository(db: db)
    }
}
