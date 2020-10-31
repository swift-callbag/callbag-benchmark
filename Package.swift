// swift-tools-version:5.0
import PackageDescription

let package = Package(
  name: "CallbagBenchmark",
  products: [
    .executable(name: "main", targets: ["main"]),
  ],
  dependencies: [
    .package(url: "https://github.com/swift-callbag/callbag-kit", from: "0.0.1"),
    .package(url: "https://github.com/ReactiveCocoa/ReactiveSwift.git", from: "6.1.0"),
    .package(url: "https://github.com/ReactiveX/RxSwift.git", .exact("6.0.0-rc.1"))
  ],
  targets: [
    .target(name: "main", dependencies: [
        "CallbagKit",
        "ReactiveSwift",
        "RxSwift",
      ]
    ),
  ]
)