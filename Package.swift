// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "SweetRPGSecurityAPI",
    dependencies: [
        // 💧 A server-side Swift web framework.
        .package(url: "https://github.com/vapor/vapor.git", from: "3.0.0"),

        // 🔵 Swift ORM (queries, models, relations, etc) built on SQLite 3.
        .package(url: "https://github.com/vapor/fluent-mysql.git", from: "3.0.0"),

        // 👤 Authentication and Authorization layer for Fluent.
        // .package(url: "https://github.com/vapor/auth.git", from: "2.0.0"),

        // JSON-API
//        .package(url: "https://github.com/vapor-tools/vapor-jsonapi.git", .branch("master"))

        // Model
        .package(url: "ssh://git@github.com/paulyhedral/sweetrpg-security-model.git", .branch("develop"))
    ],
    targets: [
        .target(name: "App", dependencies: ["FluentMySQL", "Vapor", "SweetRPGSecurityModel"]),
        .target(name: "Run", dependencies: ["App"]),
        .testTarget(name: "AppTests", dependencies: ["App"])
    ]
)
