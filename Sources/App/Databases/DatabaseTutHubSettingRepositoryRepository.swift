import Vapor
import Fluent
import Entity

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
    
    func all(_ userID: UserID) async throws -> [TutHubSettingRepository] {
        try await TutHubRepositoryModel.query(on: db)
            .filter(\.$userModel.$id == userID.value)
            .all()
            .map { model in
                try TutHubSettingRepository(
                    id: .init(value: model.requireID()),
                    name: .init(model.name),
                    title: .init(model.title)
                )
            }
    }
    
    func create(_ userID: UserID, _ repositoryName: RepositoryName, _ title: RepositoryTitle) async throws -> TutHubSettingRepository {
        let model = TutHubRepositoryModel(name: repositoryName.value, title: title.value, userID: userID.value)
        try await model.create(on: db)
        return try .init(id: .init(value: model.requireID()), name: .init(model.name), title: .init(model.title))
    }
    
    func remove(_ userID: UserID, _ repositoryName: RepositoryName) async throws {
        try await TutHubRepositoryModel.query(on: db)
            .filter(\.$userModel.$id == userID.value)
            .filter(\.$name == repositoryName.value)
            .delete()
    }
}
