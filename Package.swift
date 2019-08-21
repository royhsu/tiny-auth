// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "TinyAuth",
    products: [
        .library(
            name: "TinyAuth",
            targets: [ "TinyAuth" ]
        ),
    ],
    dependencies: [
        .package(
            url: "https://github.com/royhsu/tiny-key-value-store",
            .branch("swift-5")
        ),
    ],
    targets: [
        .target(name: "TinyAuth", dependencies: [ "TinyKeyValueStore" ]),
        .testTarget(
            name: "TinyAuthTests",
            dependencies: [ "TinyAuth", "TinyKeyValueStore" ]
        ),
    ]
)
