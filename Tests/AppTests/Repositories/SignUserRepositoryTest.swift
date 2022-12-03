@testable import App
import XCTVapor

final class SignUserRepositoryTest: XCTestCase {
    
    var app: Application = Application(.testing)
    
    var repository: SignUserRepository {
        DatabaseSignUserRepository(db: app.db, password: app.password.async)
    }
    
    override func setUp() async throws {
        
        app = Application(.testing)
        try configure(app)
        try await app.seedersSeed()
    }
    
    override func tearDown() async throws {
        try await app.seedersRevert()
        app.shutdown()
    }
    
    func test_Verifyの竹田の合格() async throws {
        let seeder = app.seeders.of(UserModel.Seeder.self)
        
        let expected = seeder.userModels["Takeda"]?.user
        let actual = try await repository.verify(.init(mailAddress: "takeda@gmail.com", password: "123@takeda"))
        
        XCTAssertEqual(actual, expected)
    }
    
    func test_Verifyの田中の合格() async throws {
        let seeder = app.seeders.of(UserModel.Seeder.self)
        
        let expected = seeder.userModels["Tanaka"]?.user
        let actual = try await repository.verify(.init(mailAddress: "tanaka@icloud.com", password: "456@tanaka"))
        
        XCTAssertEqual(actual, expected)
    }
    
    func test_Verifyの中田の合格() async throws {
        let seeder = app.seeders.of(UserModel.Seeder.self)
        
        let expected = seeder.userModels["Nakata"]?.user
        let actual = try await repository.verify(.init(mailAddress: "nakata@yahoo.co.jp", password: "789@nakata"))
        
        XCTAssertEqual(actual, expected)
    }
    
    func test_Verifyのメールアドレス違いでの不合格() async throws {
        let actual = try await repository.verify(.init(mailAddress: "takeda@gmail.com", password: "456@tanaka"))
        XCTAssertNil(actual)
    }
    
    func test_Verifyのパスワード違いでの不合格() async throws {
        let actual = try await repository.verify(.init(mailAddress: "tanaka@icloud.com", password: "123@takeda"))
        XCTAssertNil(actual)
    }
    
    func test_SignUp() async throws {
        let newUser = SignUserContent(mailAddress: "new@user.com", password: "new$user@password")
        let signUpUser = try await repository.signUp(newUser)
        
        let signInUser = try await repository.verify(newUser)
        XCTAssertEqual(signUpUser, signInUser)
    }
    
}
