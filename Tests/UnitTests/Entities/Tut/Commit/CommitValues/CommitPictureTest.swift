@testable import App
import XCTest

final class CommitPictureTest: XCTestCase {

    func test_等価() throws {
        let id = PictureID(value: UUID())
        
        let picture1 = CommitPicture(
            id: id,
            binary: try PictureData(Data(repeating: 0, count: 1)),
            filename: try PictureFilename("hello"),
            extension: .png
        )
        let picture2 = CommitPicture(
            id: id,
            binary: try PictureData(Data(repeating: 0, count: 1)),
            filename: try PictureFilename("hello"),
            extension: .png
        )
        XCTAssertTrue(picture1 == picture2)
    }
    
    func test_不等価() throws {
        let picture1 = CommitPicture(
            id: PictureID(value: UUID()),
            binary: try PictureData(Data(repeating: 0, count: 1)),
            filename: try PictureFilename("hello"),
            extension: .png
        )
        let picture2 = CommitPicture(
            id: PictureID(value: UUID()),
            binary: try PictureData(Data(repeating: 0, count: 1)),
            filename: try PictureFilename("hello"),
            extension: .png
        )
        XCTAssertFalse(picture1 == picture2)
    }
}
