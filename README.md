# CoordinatorKit

Navigation using Coordinators in Swift for UIKit and SwiftUI apps.

It is used in production by Blub Blub in:
- Speech Blubs
- Speech Blubs Pro

# Getting Started

Coordinators are objects that own larger sections of an application (for example: Onboarding, Login flow). Their main responsibility is to implement a simple messaging protocol and factories that generate screens (such as `UIViewController`s or `UIWindow`s). Screens should emit messages for certain flow related actions and leave the rest to their Coordinator.

This effectively breaks all dependencies between screens and allows for easy UI testing. It also allows screens to be reused without changes to their button and flow logic.

For example:

The base of CoordinatorKit are the following protocols:

## `CoordinatorMessagable` 
Defines protocol that all coodrinator

## `Coordinating` - defines protocol that is used for communication ()

## `CoordinatorInitializable`

## `Coordinator`



## UIKit Support

```swift
extension UIViewController {
    var coordinator: Coordinating?
}
```

# Authors

Dal Rupnik
Jure Lajlar

# License

MIT License
