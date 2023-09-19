# CoordinatorKit

Navigation using Coordinators in Swift for UIKit and SwiftUI apps. The pattern forces UI action code to call Coordinator instead of having logic for flow between different screens.

Framework is as simple as possible and easy to learn.

It is used in production by [Blub Blub](https://speechblubs.com) in:
- [Speech Blubs](https://apps.apple.com/us/app/speech-blubs-language-therapy/id1239522573)
- [Speech Blubs Pro](https://apps.apple.com/us/app/speech-blubs-pro-made-for-slps/id1669028733)

# Installation

Platform support:
- iOS 14+
- iPadOS 14+
- macOS 11+

## Swift Package Manager

In Xcode go to File → Packages → Update to Latest Package Versions and use url:

https://github.com/blubblub/CoordinatorKit

Add it to the dependencies value of your Package.swift:

```swift
dependencies: [
    .package(url: "https://github.com/blubblub/CoordinatorKit", .upToNextMajor(from: "1.0.0")),
]
```

# Getting Started

Coordinators are objects that own larger sections of an application (for example: Onboarding, Login flow). Their main responsibility is to implement a simple messaging protocol and factories that generate screens (such as `UIViewController`s or `UIWindow`s). Screens should emit messages for certain flow related actions and leave the rest to their Coordinator.

This effectively breaks all dependencies between screens and allows for easy UI testing. It also allows screens to be reused without changes to their button and flow logic.

For example:

```swift
class LoginViewController: UIViewController {
    ...
    @IBAction func continueButtonTap() {
        self.coordinator?.send(message: BasicMessage.done(self))
    }
    ...
}

```
The upper example tells Coordinator that the view controller considers itself completed. It is up to Coordinator to do any other actions, build and launch new screens, etc.

## Establishing Coordinators in your app

How to add CoordinatorKit to your app?

1. Create a base coordinator.

```swift
import CoordinatorKit

class AppCoordinator: BaseCoordinator {
    init(window: UIWindow) {
        super.init(window: window)

        // Set Root View Controller to window that is managed by Coordinator
    }
}

```

2. Initialize on app launch

```swift
class AppDelegate: UIApplicationDelegate {
    var window: UIWindow?
    var appCoordinator: AppCoordinator! = nil

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        guard let window = window else {
            return
        }

        appCoordinator = AppCoordinator(window: window)
    }
}
```

If your app initializes with scene, it is your choice whether to have each scene managed by a separate coordinator chain and one on top.

_It is recommended that one coordinator receives messages on top, this also makes it easy for debugging messages that land in._


## Building Blocks

 The base of CoordinatorKit are the following protocols:

## `CoordinatorMessagable` 
Defines protocol that all coordinator.

Some common messages already come defined as part of CoordinatorKit:

```swift
enum BasicMessage : CoordinatorMessagable {
    case done(sender: Any)
    case cancel(sender: Any)
}
```

## `Coordinating` - defines protocol that is used for communication ()

## `CoordinatorInitializable`

## `Coordinator`

## Coordinator Implementations

## `BaseCoordinator`

## `BaseComponentCoordinator`

# Flow Coordinators

## `FlowCoordinator`

## `BuildableFlowCoordinator`

# Convenience methods




# SwiftUI Support

# UIKit Support

```swift
extension UIViewController {
    var coordinator: Coordinating?
}
```

# Contributing

We welcome any kind of pull requests. If you have a problem, open an issue! :)

Something is missing? Open a pull request!

# Authors

The framework is maintained by [Blub Blub Inc.](https://speechblubs.com)

[Dal Rupnik](https://github.com/legoless)
[Jure Lajlar](https://github.com/jlajlar)

# License

MIT License
