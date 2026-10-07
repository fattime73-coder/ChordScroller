// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "ChordScroller",
    platforms: [.macOS(.v13)],
    products: [
        .executable(name: "ChordScroller", targets: ["ChordScroller"])
    ],
    targets: [
        .executableTarget(name: "ChordScroller", path: "Sources/ChordScroller")
    ]
)
