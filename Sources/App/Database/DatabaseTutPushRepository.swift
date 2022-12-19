import Vapor
import Fluent

struct DatabaseTutPushRepository: TutPushRepository {
    
    var db: Database
    
    func push(userID: UUID, repositoryName: String, data: PushData) async throws {
        guard let repository = try await findRepository(userID, repositoryName) else {
            throw Abort(.badRequest)
        }
        
        try await db.transaction { transaction in
            try await SectionModel.query(on: transaction).filter(\.$repository.$id == (try repository.requireID())).delete()
            
            let sections: [SectionModel] = try data.sections.enumerated().map { (index, section) in
                    .init(name: section.name, number: index + 1, repositoryID: try repository.requireID())
            }
            try await sections.create(on: transaction)
            
            let allCommits: [[CommitModel]] = try sections.enumerated().map { (i, sectionModel) in
                try data.sections[i].commits.enumerated().map { (index, commit) in
                        .init(step: index + 1, message: commit.message, sectionID: try sectionModel.requireID())
                }
            }
            try await allCommits
                .flatMap { $0 }
                .create(on: transaction)
            
            let allPictures = try allCommits.enumerated().flatMap { (i, commitModels) -> [[PictureModel]] in
                try commitModels.enumerated().compactMap { (j, commitModel) -> [PictureModel] in
                    let commit = data.sections[i].commits[j]
                    return try commit.pictures.map { picture -> PictureModel in
                            .init(filename: picture.name, bin: picture.bin, commitID: try commitModel.requireID())
                    }
                }
            }
            try await allPictures
                .flatMap { $0 }
                .create(on: transaction)
            
            let allCodes = try allCommits.enumerated().flatMap { (i, commitModels) -> [[SourceCodeModel]] in
                try commitModels.enumerated().compactMap { (j, commitModel) -> [SourceCodeModel] in
                    let commit = data.sections[i].commits[j]
                    return try commit.codes.map { code -> SourceCodeModel in
                            .init(filename: code.name, code: code.content, commitID: try commitModel.requireID())
                    }
                }
            }
            
            try await allCodes
                .flatMap { $0 }
                .create(on: transaction)
        }
    }
        
    private func findRepository(_ userID: UUID, _ repositoryName: String) async throws -> TutHubRepositoryModel? {
        try await TutHubRepositoryModel.query(on: db)
            .filter(\.$user.$id == userID)
            .filter(\.$name == repositoryName)
            .first()
    }
}


