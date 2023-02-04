// swift-tools-version:5.7
import PackageDescription

let package = Package(
    name: "TutHub",
    platforms: [
       .macOS(.v12)
    ],
    dependencies: [
        // 💧 A server-side Swift web framework.
        .package(url: "https://github.com/vapor/vapor.git", from: "4.0.0"),
        .package(url: "https://github.com/vapor/fluent.git", from: "4.0.0"),
        .package(url: "https://github.com/vapor/fluent-postgres-driver.git", from: "2.0.0"),
        .package(url: "https://github.com/vapor/leaf.git", from: "4.0.0"),
    ],
    targets: [
        .executableTarget(name: "Run", dependencies: [.target(name: "App")]),
        
        .target(
            name: "App",
            dependencies: [
                .product(name: "Fluent", package: "fluent"),
                .product(name: "FluentPostgresDriver", package: "fluent-postgres-driver"),
                .product(name: "Leaf", package: "leaf"),
                .product(name: "Vapor", package: "vapor"),
                .target(name: "Presentation"),
                .target(name: "Entity"),
            ],
            swiftSettings: [
                // Enable better optimizations when building in Release configuration. Despite the use of
                // the `.unsafeFlags` construct required by SwiftPM, this flag is recommended for Release
                // builds. See <https://github.com/swift-server/guides/blob/main/docs/building.md#building-for-production> for details.
                .unsafeFlags(["-cross-module-optimization"], .when(configuration: .release))
            ]
        ),
        .testTarget(name: "AppTests", dependencies: [
            .target(name: "App"),
            .product(name: "XCTVapor", package: "vapor"),
        ]),
        
        .target(name: "Entity"),
        .testTarget(name: "EntityTests", dependencies: [.target(name: "Entity")]),
        
        .target(name: "Usecase", dependencies: [
            .target(name: "Entity"),
        ]),
        .testTarget(name: "UsecaseTests", dependencies: [.target(name: "Usecase")]),
        
        .target(name: "Repository", dependencies: [
            .target(name: "Entity"),
            .target(name: "Usecase"),
        ]),
        
        .target(name: "Storage", dependencies: [
            .target(name: "Entity"),
            .target(name: "Usecase"),
            .target(name: "Repository"),
            .product(name: "Fluent", package: "fluent"),
        ]),
        .testTarget(name: "StorageTests", dependencies: [
            .product(name: "Vapor", package: "vapor"),
            .target(name: "App"),
            .target(name: "Storage"),
            .product(name: "XCTVapor", package: "vapor"),
        ]),
        
        .target(name: "Service", dependencies: [
            .target(name: "Entity"),
            .target(name: "Usecase"),
            .target(name: "Repository"),
        ]),
        .testTarget(name: "ServiceTests", dependencies: [.target(name: "Service")]),
        
        .target(name: "Presentation", dependencies: [
            .target(name: "Entity"),
            .target(name: "Usecase"),
            .target(name: "Repository"),
            .target(name: "Service"),
            .product(name: "Vapor", package: "vapor"),
        ]),
        .testTarget(name: "PresentationTests", dependencies: [
            .target(name: "Entity"),
            .target(name: "Usecase"),
            .target(name: "Presentation"),
        ]),
        
        .testTarget(name: "UnitTests", dependencies: [.target(name: "App")], path: "Tests/UnitTests"),
    ]
)
