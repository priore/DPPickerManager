// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "DPPickerManager",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v10)
    ],
    products: [
        .library(
            name: "DPPickerManager",
            targets: ["DPPickerManager"])
    ],    
    dependencies: [],
    targets: [
        .target(
            name: "DPPickerManager",
            dependencies: [],
            path: "DPPickerManager",
            exclude: ["AppDelegate.swift", "ViewController.swift", "DPPickerManager.gif", "Info.plist"],
            sources: ["Class"],
            resources: [.process("Resources")],
            linkerSettings: [
                .linkedFramework("UIKit")
            ]),
    ],
    swiftLanguageVersions: [.v5]    
)
