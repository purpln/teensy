// swift-tools-version:5.10

import PackageDescription

let package = Package(
    name: "Swift",
    products: [
        .library(name: "Swift", targets: ["Core"]),
        //.library(name: "_Concurrency", targets: ["_Concurrency"]),
    ],
    targets: [
        //.target(name: "_Concurrency", dependencies: [.target(name: "Core")], swiftSettings: [.unsafeFlags(["-nostdimport", "-parse-stdlib"])]),
        //.target(name: "_StringProcessing", dependencies: [.target(name: "Core")], swiftSettings: [.unsafeFlags(["-nostdimport", "-parse-stdlib"])]),
        .target(name: "Core", dependencies: [.target(name: "Runtime")], swiftSettings: [
            .unsafeFlags(["-nostdimport", "-parse-stdlib",  "-module-name", "Swift"]),
            .unsafeFlags(["-enable-experimental-feature", "Extern"]),
            .unsafeFlags(["-enable-experimental-feature", "SymbolLinkageMarkers"]),
            .unsafeFlags(["-enable-experimental-feature", "NoncopyableGenerics"]),
            .unsafeFlags(["-enable-experimental-feature", "NonescapableTypes"]),
            .unsafeFlags(["-enable-experimental-feature", "FullTypedThrows"]),
            .unsafeFlags(["-Xfrontend", "-disable-objc-interop"]),
        ]),
        //.target(name: "Onone", dependencies: [.target(name: "Core")], swiftSettings: [.unsafeFlags(["-nostdimport", "-parse-stdlib"])]),
        .target(name: "Runtime", publicHeadersPath: ".", swiftSettings: [.unsafeFlags(["-nostdimport", "-parse-stdlib"])]),
    ]
)
