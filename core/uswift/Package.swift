// swift-tools-version:5.10

import PackageDescription

let package = Package(
    name: "Swift",
    products: [
        .library(name: "Swift", targets: ["Core"])
    ],
    targets: [
        //.target(name: "_Concurrency", dependencies: [.target(name: "Core")], swiftSettings: [.unsafeFlags(["-nostdimport", "-parse-stdlib"])]),
        //.target(name: "_StringProcessing", dependencies: [.target(name: "Core")], swiftSettings: [.unsafeFlags(["-nostdimport", "-parse-stdlib"])]),
        .target(name: "Core", dependencies: [.target(name: "Runtime")], swiftSettings: [
            .unsafeFlags(["-nostdimport", "-parse-stdlib",  "-module-name", "Swift"]),
            .unsafeFlags(["-enable-experimental-feature", "Extern"]),
            .unsafeFlags(["-enable-experimental-feature", "SymbolLinkageMarkers"]),
            .unsafeFlags([
                //"-Xfrontend", "-requirement-machine-protocol-signatures=on",
                //"-Xfrontend", "-requirement-machine-inferred-signatures=on",
                //"-Xfrontend", "-requirement-machine-abstract-signatures=on",
            ]),
            //.enableUpcomingFeature("FullTypedThrows")
        ]),
        //.target(name: "Onone", dependencies: [.target(name: "Core")], swiftSettings: [.unsafeFlags(["-nostdimport", "-parse-stdlib"])]),
        .target(name: "Runtime", publicHeadersPath: ".", swiftSettings: [.unsafeFlags(["-nostdimport", "-parse-stdlib"])]),
    ]
)
