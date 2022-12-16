import Fluent
import FluentPostgresDriver
import Leaf
import Vapor

// configures your application
public func configure(_ app: Application) throws {
//     uncomment to serve files from /Public folder
     app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

    app.databases.use(.postgres(
        hostname: Environment.get("DATABASE_HOST") ?? "db",
        port: Environment.get("DATABASE_PORT").flatMap(Int.init(_:)) ?? PostgresConfiguration.ianaPortNumber,
        username: Environment.get("DATABASE_USERNAME") ?? "vapor_username",
        password: Environment.get("DATABASE_PASSWORD") ?? "vapor_password",
        database: Environment.get("DATABASE_NAME") ?? "vapor_database"
    ), as: .psql)
    
    app.migrations.add(UserModel.Migration())
    app.seeders.add(UserModel.Seeder())
    
    app.migrations.add(SignUserModel.Migration())
    app.seeders.add(try SignUserModel.Seeder(hasher: app.password, userModelSeeder: app.seeders.of(UserModel.Seeder.self)))
    
    app.migrations.add(TutHubRepositoryModel.Migration())
    app.migrations.add(TagModel.Migration())
    app.migrations.add(CommitModel.Migration())
    app.migrations.add(SourceCodeModel.Migration())
    app.migrations.add(PictureModel.Migration())
    
    app.views.use(.leaf)
    
    app.middleware.use(app.sessions.middleware)
    app.middleware.use(UserSessionAuthenticator())
    
    let timeout = HTTPClient.Configuration.Timeout(connect: .seconds(60), read: .seconds(60))
    app.http.client.configuration.timeout = timeout
    
    let corsConfiguration = CORSMiddleware.Configuration(
        allowedOrigin: .custom(Environment.get("TUTPAGE_ORIGIN") ?? "http://localhost:5173"),
        allowedMethods: [.GET],
        allowedHeaders: [.accept, .authorization, .contentType, .origin, .xRequestedWith, .userAgent, .accessControlAllowOrigin]
    )
    let cors = CORSMiddleware(configuration: corsConfiguration)
    // cors middleware should come before default error middleware using `at: .beginning`
    app.middleware.use(cors, at: .beginning)
    
    app.routes.defaultMaxBodySize = "500mb"
    
    // register routes
    try routes(app)
}
