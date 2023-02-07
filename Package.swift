// swift-tools-version:5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription
import Foundation

let package = Package(
    name: "GBADeltaCore",
    platforms: [
        .iOS(.v12),
        .macOS(.v11),
        .tvOS(.v12)
    ],
    products: [
        .library(
            name: "GBADeltaCore",
            targets: ["GBADeltaCore"])
    ],
    dependencies: [
        //        .package(url: "https://github.com/rileytestut/DeltaCore.git", .branch("main"))
        .package(path: "../DeltaCore/")
    ],
    targets: [
        .target(
            name: "GBASwift",
            dependencies: ["DeltaCore"]
        ),

        .target(
            name: "GBABridge",
            dependencies: ["DeltaCore", "vbam", "GBASwift"],
//            publicHeadersPath: "include",
            cSettings: [
                .unsafeFlags([
                    "-fmodules",
                    "-fcxx-modules"
                ]),
            ],
            cxxSettings: [
                .unsafeFlags([
                    "-fmodules",
                    "-fcxx-modules"
                ]),
            ],
            swiftSettings: [
                .unsafeFlags([
                    "-I", "../vbam/libvbam/src"
                ])
            ],
            linkerSettings: [
                .linkedFramework("UIKit", .when(platforms: [.iOS, .tvOS, .macCatalyst])),
                .linkedFramework("AVFoundation", .when(platforms: [.iOS, .tvOS, .macCatalyst])),
                .linkedFramework("GLKit", .when(platforms: [.iOS, .tvOS, .macCatalyst])),
            ]
        ),

        .target(
            name: "GBADeltaCore",
            dependencies: ["DeltaCore", "vbam", "GBASwift", "GBABridge"],
            resources: [
                .copy("Resources/Controller Skin/Standard.deltaskin"),
                .copy("Resources/Standard.deltamapping"),
            ],
//            publicHeadersPath: "include",
            swiftSettings: [
                .unsafeFlags([
                    "-enable-experimental-cxx-interop"
                    //                        "-I", "Sources/CXX/include",
                    //                        "-I", "\(sdkRoot)/usr/include",
                    //                        "-I", "\(cPath)",
                    //                        "-lc++",
//                    "-Xfrontend", "-disable-implicit-concurrency-module-import",
//                    "-Xcc", "-nostdinc++"
                ])
            ],
            linkerSettings: [
                .linkedFramework("UIKit", .when(platforms: [.iOS, .tvOS, .macCatalyst])),
                .linkedFramework("AVFoundation", .when(platforms: [.iOS, .tvOS, .macCatalyst])),
                .linkedFramework("GLKit", .when(platforms: [.iOS, .tvOS, .macCatalyst])),
            ]
        ),

        .target(
            name: "vbam",
            exclude: [

            ],
            sources: [

            ],
//            publicHeadersPath: "include",
            cSettings: [

            ],
            cxxSettings: [

            ]
        ),
    ],
    swiftLanguageVersions: [.v5],
    cLanguageStandard: .c11,
    cxxLanguageStandard: .cxx11
)
