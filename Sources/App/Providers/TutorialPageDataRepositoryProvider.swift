import Vapor

extension Request {
    var tutorialPageDataRepository: TutorialPageDataRepository {
        DatabaseTutorialPageRepository(db: db)
    }
}
