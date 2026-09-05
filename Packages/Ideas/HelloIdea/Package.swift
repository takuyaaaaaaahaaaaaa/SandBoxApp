// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "HelloIdea",
    platforms: [.iOS(.v17)],
    products: [
        .library(name: "HelloIdea", targets: ["HelloIdea"])
    ],
    dependencies: [
        .package(path: "../../IdeaKit"),
        .package(path: "../../Core"),
    ],
    targets: [
        .target(
            name: "HelloIdea",
            dependencies: ["IdeaKit", "Core"]
        )
    ]
)
