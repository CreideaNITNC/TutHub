import Vapor
import Fluent

struct DatabaseSectionRepository: SectionRepoistory {
    
    var db: Database
    
    func find(_ user: User, _ repositoryName: RepositoryName, _ page: SectionPage) async throws -> Section? {
        try await SectionModel.query(on: db)
            .join(TutHubRepositoryModel.self, on: \TutHubRepositoryModel.$id == \SectionModel.$repository.$id)
            .filter(TutHubRepositoryModel.self, \.$userModel.$id == user.id.value)
            .filter(TutHubRepositoryModel.self, \.$name == repositoryName.value)
            .filter(\.$number == page.value)
            .first()
            .map { try .init(id: .init(value: $0.requireID())) }
    }
}
