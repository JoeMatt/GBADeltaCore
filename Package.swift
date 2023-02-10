// swift-tools-version:5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

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
            targets: ["GBADeltaCore"]),
        .library(
            name: "GBADeltaCoreStatic",
            type: .static,
            targets: ["GBADeltaCore"]),
        .library(
            name: "GBADeltaCoreDynamic",
            type: .dynamic,
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
            dependencies: ["DeltaCore", "visualboyadvance-m", "GBASwift"],
            publicHeadersPath: "",
            cSettings: [
                .headerSearchPath("../visualboyadvance-m/visualboyadvance-m/src/"),
                .unsafeFlags([
                    "-fmodules",
                    "-fcxx-modules"
                ]),
            ],
            cxxSettings: [
                .headerSearchPath("../visualboyadvance-m/visualboyadvance-m/src/"),
                .unsafeFlags([
                    "-fmodules",
                    "-fcxx-modules"
                ]),
            ],
            swiftSettings: [
                .unsafeFlags([
                    "-enable-experimental-cxx-interop",
                    "-I", "../visualboyadvance-m/visualboyadvance-m/src/",
                ])
            ],
            linkerSettings: [
                .linkedFramework("UIKit", .when(platforms: [.iOS, .tvOS, .macCatalyst])),
                .linkedFramework("CoreMotion", .when(platforms: [.iOS, .tvOS, .macCatalyst])),
            ]
        ),

        .target(
            name: "GBADeltaCore",
            dependencies: ["DeltaCore", "visualboyadvance-m", "GBASwift", "GBABridge"],
            exclude: [
                "Resources/Controller Skin/info.json",
                "Resources/Controller Skin/ipad_landscape.pdf",
                "Resources/Controller Skin/ipad_portrait.pdf",
                "Resources/Controller Skin/ipad_splitview_landscape.pdf",
                "Resources/Controller Skin/iphone_edgetoedge_landscape.pdf",
                "Resources/Controller Skin/iphone_edgetoedge_portrait.pdf",
                "Resources/Controller Skin/iphone_landscape.pdf",
                "Resources/Controller Skin/iphone_portrait.pdf"
            ],
            resources: [
                .copy("Resources/Controller Skin/Standard.deltaskin"),
                .copy("Resources/Standard.deltamapping"),
                .copy("Resources/vba-over.ini"),
            ],
            cSettings: [
                .headerSearchPath("../visualboyadvance-m/visualboyadvance-m/src/"),
                .headerSearchPath("../visualboyadvance-m/visualboyadvance-m/src/common"),
                .headerSearchPath("../visualboyadvance-m/visualboyadvance-m/src/gb"),
                .headerSearchPath("../visualboyadvance-m/visualboyadvance-m/src/gba"),
                .unsafeFlags([
                    "-fmodules",
                    "-fcxx-modules"
                ]),
            ],
            cxxSettings: [
                .headerSearchPath("../visualboyadvance-m/visualboyadvance-m/src/"),
                .headerSearchPath("../visualboyadvance-m/visualboyadvance-m/src/common"),
                .headerSearchPath("../visualboyadvance-m/visualboyadvance-m/src/gb"),
                .headerSearchPath("../visualboyadvance-m/visualboyadvance-m/src/gba"),
                .unsafeFlags([
                    "-fmodules",
                    "-fcxx-modules"
                ]),
            ],
            swiftSettings: [
                .unsafeFlags([
                    "-enable-experimental-cxx-interop",
                    "-I", "../visualboyadvance-m/visualboyadvance-m/src/",
                ])
            ],
            linkerSettings: [
                .linkedFramework("UIKit", .when(platforms: [.iOS, .tvOS, .macCatalyst])),
                .linkedFramework("AVFoundation", .when(platforms: [.iOS, .tvOS, .macCatalyst])),
            ]
        ),
        .target(
            name: "SFML",
            exclude: [
                "src/SFML/Audio",
                "src/SFML/Graphics",
                "src/SFML/Main",
                "src/SFML/Network/Win32",
                "src/SFML/System/Clock.cpp",
                "src/SFML/System/FileInputStream.cpp",
                "src/SFML/System/Lock.cpp",
                "src/SFML/System/MemoryInputStream.cpp",
                "src/SFML/System/Mutex.cpp",
                "src/SFML/System/Sleep.cpp",
                "src/SFML/System/ThreadLocal.cpp",
                "src/SFML/System/Android/",
                "src/SFML/System/Unix/ClockImpl.cpp",
                "src/SFML/System/Unix/MutexImpl.cpp",
                "src/SFML/System/Unix/SleepImpl.cpp",
                "src/SFML/System/Unix/TheadLocalImpl.cpp",
                "src/SFML/System/Win32/",
                "src/SFML/Window",
            ],
            publicHeadersPath: "include",
            cSettings: [
                .headerSearchPath("include/"),
                .headerSearchPath("src/"),
            ],
            cxxSettings: [
                .headerSearchPath("include/"),
                .headerSearchPath("src/"),
            ]
        ),

        .target(
            name: "visualboyadvance-m",
            dependencies: ["SFML"],
            exclude: [
                "visualboyadvance-m/cmake/",
                "visualboyadvance-m/data/",
                "visualboyadvance-m/dependencies/",
                "visualboyadvance-m/doc/",
                "visualboyadvance-m/po/",
                "visualboyadvance-m/project/",
                "visualboyadvance-m/src/art/",
                "visualboyadvance-m/src/common/ffmpeg.cpp",
                "visualboyadvance-m/src/common/SoundSDL.cpp",
                "visualboyadvance-m/src/debian/",
                "visualboyadvance-m/src/filters/",
                "visualboyadvance-m/src/filters/hq/",
                "visualboyadvance-m/src/filters/xBRZ/",
                "visualboyadvance-m/src/gba/debugger-expr-lex.cpp",
                "visualboyadvance-m/src/libretro/",
                "visualboyadvance-m/src/sdl/",
                "visualboyadvance-m/src/vita/",
                "visualboyadvance-m/src/wx/",
                "visualboyadvance-m/src/wx/icons/",
                "visualboyadvance-m/src/wx/widgets/",
                "visualboyadvance-m/src/wx/xrc/",
                "visualboyadvance-m/tools/builder",
                "visualboyadvance-m/tools/linux",
                "visualboyadvance-m/tools/osx",
                "visualboyadvance-m/tools/unix",
                "visualboyadvance-m/tools/win",
                "visualboyadvance-m/CHANGELOG.md",
                "visualboyadvance-m/CMakeLists.txt",
                "visualboyadvance-m/installdeps.sh",
                "visualboyadvance-m/installer.nsi",
                "visualboyadvance-m/README.md",
                "visualboyadvance-m/todo.md"
            ],
            sources: [
                "visualboyadvance-m/src/Util.cpp",

                "visualboyadvance-m/src/apu/Blip_Buffer.cpp",
                "visualboyadvance-m/src/apu/Effects_Buffer.cpp",
                "visualboyadvance-m/src/apu/Gb_Apu_State.cpp",
                "visualboyadvance-m/src/apu/Gb_Apu.cpp",
                "visualboyadvance-m/src/apu/Gb_Oscs.cpp",
                "visualboyadvance-m/src/apu/Multi_Buffer.cpp",

                "visualboyadvance-m/src/common/ConfigManager.cpp",
                "visualboyadvance-m/src/common/dictionary.c",
                "visualboyadvance-m/src/common/iniparser.c",
                "visualboyadvance-m/src/common/memgzio.c",
                "visualboyadvance-m/src/common/Patch.cpp",


                "visualboyadvance-m/src/gba/BreakpointStructures.cpp",
                "visualboyadvance-m/src/gba/CheatSearch.cpp",
                "visualboyadvance-m/src/gba/Cheats.cpp",
                "visualboyadvance-m/src/gba/EEprom.cpp",
                "visualboyadvance-m/src/gba/EEprom.h",
                "visualboyadvance-m/src/gba/Flash.cpp",
                "visualboyadvance-m/src/gba/GBA-arm.cpp",
                "visualboyadvance-m/src/gba/GBA-thumb.cpp",
                "visualboyadvance-m/src/gba/GBA.cpp",
                "visualboyadvance-m/src/gba/GBA.h",
                "visualboyadvance-m/src/gba/GBAGfx.cpp",
                "visualboyadvance-m/src/gba/GBALink.cpp",
                "visualboyadvance-m/src/gba/GBASockClient.cpp",
                "visualboyadvance-m/src/gba/Globals.cpp",
                "visualboyadvance-m/src/gba/Mode0.cpp",
                "visualboyadvance-m/src/gba/Mode1.cpp",
                "visualboyadvance-m/src/gba/Mode2.cpp",
                "visualboyadvance-m/src/gba/Mode3.cpp",
                "visualboyadvance-m/src/gba/Mode4.cpp",
                "visualboyadvance-m/src/gba/Mode5.cpp",
                "visualboyadvance-m/src/gba/RTC.cpp",
                "visualboyadvance-m/src/gba/Sound.cpp",
                "visualboyadvance-m/src/gba/Sram.cpp",
                "visualboyadvance-m/src/gba/agbprint.cpp",
                "visualboyadvance-m/src/gba/armdis.cpp",
                "visualboyadvance-m/src/gba/bios.cpp",
                "visualboyadvance-m/src/gba/debugger-expr-lex.c",
                "visualboyadvance-m/src/gba/debugger-expr-yacc.cpp",
                "visualboyadvance-m/src/gba/elf.cpp",
                "visualboyadvance-m/src/gba/ereader.cpp",
                "visualboyadvance-m/src/gba/gbafilter.cpp",
                "visualboyadvance-m/src/gba/remote.cpp",

                "visualboyadvance-m/src/gb/GB.cpp",
                "visualboyadvance-m/src/gb/gbCheats.cpp",
                "visualboyadvance-m/src/gb/gbDis.cpp",
                "visualboyadvance-m/src/gb/gbGfx.cpp",
                "visualboyadvance-m/src/gb/gbGlobals.cpp",
                "visualboyadvance-m/src/gb/gbMemory.cpp",
                "visualboyadvance-m/src/gb/gbPrinter.cpp",
                "visualboyadvance-m/src/gb/gbSGB.cpp",
                "visualboyadvance-m/src/gb/gbSound.cpp",


                "visualboyadvance-m/fex/fex/Binary_Extractor.cpp",
                "visualboyadvance-m/fex/fex/Data_Reader.cpp",
                "visualboyadvance-m/fex/fex/File_Extractor.cpp",
                "visualboyadvance-m/fex/fex/Gzip_Extractor.cpp",
                "visualboyadvance-m/fex/fex/Gzip_Reader.cpp",
                "visualboyadvance-m/fex/fex/Rar_Extractor.cpp",
                "visualboyadvance-m/fex/fex/Zip7_Extractor.cpp",
                "visualboyadvance-m/fex/fex/Zip_Extractor.cpp",
                "visualboyadvance-m/fex/fex/Zlib_Inflater.cpp",
                "visualboyadvance-m/fex/fex/blargg_common.cpp",
                "visualboyadvance-m/fex/fex/blargg_errors.cpp",
                "visualboyadvance-m/fex/fex/fex.cpp",

                "visualboyadvance-m/fex/7z_C/7zAlloc.c",
                "visualboyadvance-m/fex/7z_C/7zBuf.c",
                "visualboyadvance-m/fex/7z_C/7zCrc.c",
                "visualboyadvance-m/fex/7z_C/7zCrcOpt.c",
                "visualboyadvance-m/fex/7z_C/7zDec.c",
                "visualboyadvance-m/fex/7z_C/7zIn.c",
                "visualboyadvance-m/fex/7z_C/7zStream.c",
                "visualboyadvance-m/fex/7z_C/Bcj2.c",
                "visualboyadvance-m/fex/7z_C/Bra.c",
                "visualboyadvance-m/fex/7z_C/Bra86.c",
                "visualboyadvance-m/fex/7z_C/CpuArch.c",
                "visualboyadvance-m/fex/7z_C/Lzma2Dec.c",
                "visualboyadvance-m/fex/7z_C/LzmaDec.c",
                "visualboyadvance-m/fex/7z_C/Ppmd7.c",
                "visualboyadvance-m/fex/7z_C/Ppmd7Dec.c"
            ],
            publicHeadersPath: "include",
            cSettings: [
                .headerSearchPath("include/"),
                .headerSearchPath("visualboyadvance-m/fex/"),
                .headerSearchPath("visualboyadvance-m/src/"),
                .headerSearchPath("visualboyadvance-m/src/common"),
                .define("C_CORE"),
                .define("NO_PNG"),
                .define("FINAL_VERSION"),
                .define("PKGDATADIR"),
                .define("SYSCONF_INSTALL_DIR"),
                .define("NO_DEBUGGER"),
                .define("BKPT_SUPPORT"),
                .define("HAVE_ARPA_INET_H"),
                .define("NO_LINK"),
                .define("STATIC_LIBRARY", to: "1"),
            ],
            cxxSettings: [
                .headerSearchPath("include/"),
                .headerSearchPath("visualboyadvance-m/fex/"),
                .headerSearchPath("visualboyadvance-m/src/"),
                .headerSearchPath("visualboyadvance-m/src/common"),
                .define("C_CORE"),
                .define("NO_PNG"),
                .define("FINAL_VERSION"),
                .define("PKGDATADIR"),
                .define("SYSCONF_INSTALL_DIR"),
                .define("NO_DEBUGGER"),
                .define("BKPT_SUPPORT"),
                .define("HAVE_ARPA_INET_H"),
                .define("NO_LINK"),
                .define("STATIC_LIBRARY", to: "1"),
            ]
        ),
    ],
    swiftLanguageVersions: [.v5],
    cLanguageStandard: .c99,
    cxxLanguageStandard: .gnucxx11
)
