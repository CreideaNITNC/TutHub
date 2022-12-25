import Vapor
import Fluent

struct DatabaseTutHubSettingRepositoryRepository: TutHubSettingRepositoryRepository {
    
    var db: Database
    
    func find(_ userID: UserID, _ repositoryName: RepositoryName) async throws -> TutHubSettingRepository? {
        try await TutHubRepositoryModel.query(on: db)
            .filter(\.$userModel.$id == userID.value)
            .filter(\.$name == repositoryName.value)
            .first()
            .map { model in
                try TutHubSettingRepository(
                    id: .init(value: model.requireID()),
                    name: .init(model.name),
                    title: .init(model.title)
                )
            }
    }
}
