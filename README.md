> [!WARNING]
> This repository will no longer be maintained. The source content will be moved to the [ScribbleFoundation](https://github.com/ScribbleLabApp/ScribbleFoundation) repository. Please check there for future updates and contributions.

# ScribbleCoreServices

ScribbleCoreServices-SDK provides essential core services for ScribbleLabApp's iOS applications, offering a suite of functionalities to streamline development and enhance user experience.

## 🖥️ Installation
### Requirements
- iOS 17.0+
- Xcode 15.0+
- Swift 5.5

#### Swift Package Manager (recommended)

You can install `ScribbleCoreServices-SDK` into your Xcode project via SPM. To learn more about SPM, click [here](https://swift.org/package-manager/)

1. In Xcode 15, open your project and navigate to File → Swift Packages → Add Package Dependency...
2. Paste the repository URL (https://github.com/ScribbleLabApp/ScribbleCoreServices-SDK.git) and click Next.
3. For Version, verify it's **Up to next major**.
4. Click Next and select the ScribbleCoreServices-SDK package.
5. Click Finish.

You can also add it to the dependencies of your `Package.swift` file:
```swift
dependencies: [
  .package(url: "https://github.com/ScribbleLabApp/ScribbleCoreServices-SDK.git", .upToNextMajor(from: "0.1.0"))
]
```

#### CocoaPods (Deprecated)

To install with [CocoaPods](http://cocoapods.org/), simply add this in your Podfile:

```ruby
platform :ios, '17.0'

target 'YourApp' do
  use_frameworks!
  pod 'ScribbleCoreServices-SDK'
end
```

#### Carthage (Deprecated)

To install with Carthage, simply add this in your Cartfile:

```ruby
github "ScribbleLabApp/ScribbleCoreServices-SDK"
```

## 🚀 Quickstart
> Before you start, please star ⭐️ this repository. Your star is our biggest motivation to pull all-nighters and maintain this open-source project. If you like the idea behind this project, please share it with your friends, colleagues, or anyone who might find it valuable.

### 🛠️ Usage

## 📖 Cheatsheet

### Protocols

### Modifiers

### Structs

## 💪 Contribute

Contributions are welcome here for coders and non-coders alike. If you encounter any issues, have concerns, or any comments, please do not hesitate to let us know. Open a discussion, issue, or [email us](scribblelabapp.dev@gmail.com). As a developer, we understand the importance of clear documentation and assistance, and we'll be happy to help in any way we can.

### Support Us
Your support is valuable to us and helps us dedicate more time to enhancing and maintaining this repository. Here's how you can contribute:

⭐️ Leave a Star: If you find this repository useful or interesting, please consider leaving a star on GitHub. Your stars help us gain visibility and encourage others in the community to discover and benefit from this work.

📲 Share with Friends: If you like the idea behind this project, please share it with your friends, colleagues, or anyone who might find it valuable.
