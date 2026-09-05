// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "IdeaKit",
    platforms: [.iOS(.v17)],
    products: [
        .library(name: "IdeaKit", targets: ["IdeaKit"])
    ],
    targets: [
        .target(name: "IdeaKit")
    ]
)
