# CoordinatorKit

Navigation using Coordinators in Swift for UIKit and SwiftUI apps.

It is used in production by Blub Blub in:
- Speech Blubs
- Speech Blubs Pro

# Getting Started

Coordinators are objects that own larger sections of an application (for example: Onboarding, Login flow). Their main responsibility is to implement

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
