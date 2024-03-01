// swift-tools-version:5.9

import PackageDescription

let package = Package(
    name: "Swift",
    products: [
        .library(name: "Swift", targets: ["Core"])
    ],
    targets: [
        //.target(name: "_Concurrency", dependencies: [.target(name: "Core")], swiftSettings: [.unsafeFlags(["-nostdimport", "-parse-stdlib"])]),
        //.target(name: "_StringProcessing", dependencies: [.target(name: "Core")], swiftSettings: [.unsafeFlags(["-nostdimport", "-parse-stdlib"])]),
        .target(name: "Core", dependencies: [.target(name: "Runtime")], swiftSettings: [.unsafeFlags(["-nostdimport", "-parse-stdlib", "-Xfrontend", "-enable-resilience", "-parse-as-library", "-module-name", "Swift"])]),
        //.target(name: "Onone", dependencies: [.target(name: "Core")], swiftSettings: [.unsafeFlags(["-nostdimport", "-parse-stdlib"])]),
        .target(name: "Runtime", publicHeadersPath: ".", cSettings: [.headerSearchPath(".")]),
    ]
)
