import Vapor
import Fluent

struct DatabaseTutPushRepository: TutPushRepository {
    
    var db: Database
    
    func push(userID: UUID, repositoryName: String, data: PushData) async throws {
        guard let repository = try await findRepository(userID, repositoryName) else {
            throw Abort(.badRequest)
        }
        
        try await db.transaction { transaction in
            try await TagModel.query(on: transaction).filter(\.$repository.$id == (try repository.requireID())).delete()
            
            let tags: [TagModel] = try data.tags.enumerated().map { (index, tag) in
                    .init(name: tag.name, number: index + 1, repositoryID: try repository.requireID())
            }
            try await repository.$tags.create(tags, on: transaction)
            
            await withThrowingTaskGroup(of: Void.self, returning: Void.self) { tagGroup in
                for i in 0 ..< tags.count {
                    tagGroup.addTask {
                        let tagModel = tags[i]
                        let commits: [CommitModel] = try data.tags[i].commits.enumerated().map { (index, commit) in
                                .init(step: index + 1, message: commit.message, tagID: try tagModel.requireID())
                        }
                        try await tagModel.$commits.create(commits, on: transaction)
                        
                        await withThrowingTaskGroup(of: Void.self) { commitGroup in
                            for j in 0 ..< commits.count {
                                commitGroup.addTask {
                                    let commitModel = commits[j]
                                    let files: (pictures: [PictureModel], codes: [SourceCodeModel]) = try data.tags[i].commits[j].files
                                        .reduce((pictures: [], codes: [])) { (all, file) in
                                            if file.type == .text {
                                                return (pictures: all.pictures, codes: all.codes + [.init(
                                                    filename: file.name,
                                                    code: file.content,
                                                    commitID: try commitModel.requireID()
                                                )])
                                            } else {
                                                return (pictures: all.pictures + [.init(
                                                    filename: file.name,
                                                    bin: file.content,
                                                    commitID: try commitModel.requireID()
                                                )], codes: all.codes)
                                            }
                                        }
                                    async let createPictures: () = commitModel.$pictures.create(files.pictures, on: transaction)
                                    async let createCodes: () = commitModel.$codes.create(files.codes, on: transaction)
                                    _ = try await [createPictures, createCodes]
                                }
                            }
                        }
                    }
                }
            }
            
            for i in 0 ..< tags.count {
                let tagModel = tags[i]
                let commits: [CommitModel] = try data.tags[i].commits.enumerated().map { (index, commit) in
                        .init(step: index + 1, message: commit.message, tagID: try tagModel.requireID())
                }
                try await tagModel.$commits.create(commits, on: transaction)
                for j in 0 ..< commits.count {
                    let commitModel = commits[j]
                    let files: (pictures: [PictureModel], codes: [SourceCodeModel]) = try data.tags[i].commits[j].files
                        .reduce((pictures: [], codes: [])) { (all, file) in
                            if file.type == .text {
                                return (pictures: all.pictures, codes: all.codes + [.init(
                                    filename: file.name,
                                    code: file.content,
                                    commitID: try commitModel.requireID()
                                )])
                            } else {
                                return (pictures: all.pictures + [.init(
                                    filename: file.name,
                                    bin: file.content,
                                    commitID: try commitModel.requireID()
                                )], codes: all.codes)
                            }
                        }
                    async let createPictures: () = commitModel.$pictures.create(files.pictures, on: transaction)
                    async let createCodes: () = commitModel.$codes.create(files.codes, on: transaction)
                    _ = try await [createPictures, createCodes]
                }
            }
        }
    }
        
    private func findRepository(_ userID: UUID, _ repositoryName: String) async throws -> TutHubRepositoryModel? {
        try await TutHubRepositoryModel.query(on: db)
            .filter(\.$user.$id == userID)
            .filter(\.$name == repositoryName)
            .first()
    }
}


