import Vapor
import Fluent

struct DatabaseTutPushRepository: TutPushRepository {
    
    var db: Database
    
    
    func push(_ repository: TutHubContentRepository) async throws {
        try await db.transaction { transaction in
            try await deleteSection(repository.id, on: transaction)
            
            let sectionIDs = try await createSections(repository, on: transaction)
            let commitIDs = try await createCommits(repository, sectionIDs, on: transaction)
            
            try await createPictures(repository, commitIDs, on: transaction)
            try await createCodes(repository, commitIDs, on: transaction)
        }
    }
    
    private func deleteSection(_ repositoryID: RepositoryID, on transaction: Database) async throws {
        try await SectionModel.query(on: transaction)
            .filter(\.$repository.$id == repositoryID.value)
            .delete()
    }
    
    private func createSections(_ repository: TutHubContentRepository, on transaction: Database) async throws -> [SectionID] {
        let sections = repository.sections
            .enumerated()
            .map { (index, section) in
                SectionModel(name: section.title.value, number: index + 1, repositoryID: repository.id.value)
            }
        try await sections.create(on: transaction)
        return try sections.map { SectionID(value: try $0.requireID()) }
    }
    
    private func createCommits(_ repository: TutHubContentRepository, _ sectionIDs: [SectionID], on transaction: Database) async throws -> [[CommitID]] {
        let commits: [[CommitModel]] = repository.sections.map { section in
            section.commits.enumerated().map { (index, commit) in
                    .init(step: index + 1, message: commit.message.value, sectionID: section.id.value)
            }
        }
        try await commits.flatMap({$0}).create(on: transaction)
        return try commits.map { try $0.map { CommitID(value: try $0.requireID()) } }
    }
    
    private func createPictures(_ repository: TutHubContentRepository, _ commitIDs: [[CommitID]], on transaction: Database) async throws {
        try await repository.sections.enumerated().flatMap { (sectionIndex, section) in
            section.commits.enumerated().flatMap { (commitIndex, commit) in
                commit.pictures.enumerated().map { (pictureIndex, picture) in
                    PictureModel(
                        filename: picture.filename.value,
                        extension: picture.extension,
                        bin: picture.binary.value,
                        number: pictureIndex + 1,
                        commitID: commitIDs[sectionIndex][commitIndex].value
                    )
                }
            }
        }.create(on: transaction)
    }
    
    private func createCodes(_ repository: TutHubContentRepository, _ commitIDs: [[CommitID]], on transaction: Database) async throws {
        try await repository.sections.enumerated().flatMap { (sectionIndex, section) in
            section.commits.enumerated().flatMap { (commitIndex, commit) in
                commit.codes.map { code in
                    SourceCodeModel(
                        filename: code.filename.value,
                        code: code.text.value,
                        commitID: commitIDs[sectionIndex][commitIndex].value
                    )
                }
            }
        }.create(on: transaction)
    }
}


