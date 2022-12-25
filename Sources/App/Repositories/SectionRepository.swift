import Vapor

protocol SectionRepoistory {
    func find(_ user: User, _ repositoryName: RepositoryName, _ page: SectionPage) async throws -> Section?
}

extension Request {
    var sectionRepository: SectionRepoistory {
        DatabaseSectionRepository(db: db)
    }
}
