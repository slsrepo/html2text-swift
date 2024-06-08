// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "html2text-swift",
    products: [
        .library(name: "HTML2Text", targets: ["HTML2Text"]),
    ],
    dependencies: [
        .package(url: "https://github.com/ttscoff/SwiftSoup.git", from: "2.0.0"),
    ],
    targets: [
        .target(name: "HTML2Text", dependencies: ["SwiftSoup"]),
        .testTarget(
            name: "HTML2TextTests",
            dependencies: ["HTML2Text"])
    ]
)
