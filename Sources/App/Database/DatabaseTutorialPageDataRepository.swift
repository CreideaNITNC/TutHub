import Vapor
import Fluent

struct DatabaseTutorialPageRepository: TutorialPageDataRepository {
    
    var db: Database
    
    func find(userID: UUID, repositoryName: String, page: Int) async throws -> TutorialPageData {
        guard
            let repository = try await findRepository(userID, repositoryName),
            let tag = try await eagerLoadTagModel(repository: repository, page: page)
        else { throw Abort(.notFound) }
      
        return .init(
            userID: userID.uuidString,
            repositoryName: repositoryName,
            pageNumber: page,
            pageTitle: repository.name,
            commits: tag.commits.map { commit in
                    .init(
                        step: commit.step,
                        message: commit.message,
                        codes: commit.codes.map { code in
                                .init(filename: code.filename, code: code.code)
                        },
                        pictures: commit.pictures.map { picture in
                                .init(filename: picture.filename, encodedBinaryData: picture.bin)
                        }
                    )
            }
        )
    }
    
    private func findRepository(_ userID: UUID, _ repositoryName: String) async throws -> TutHubRepositoryModel? {
        try await TutHubRepositoryModel.query(on: db)
            .filter(\.$user.$id == userID)
            .filter(\.$name == repositoryName)
            .first()
    }
    
    private func eagerLoadTagModel(repository: TutHubRepositoryModel, page: Int) async throws -> TagModel? {
        return try await TagModel.query(on: db)
            .filter(\.$repository.$id == repository.requireID())
            .filter(\.$number == page)
            .with(\.$commits) { commit in
                commit.with(\.$codes)
                commit.with(\.$pictures)
            }
            .first()
    }
}
