# CoordinatorKit

Navigation using Coordinators in Swift for UIKit and SwiftUI apps. The pattern forces UI action code to call Coordinator instead of having logic for flow between different screens.

It is used in production by [Blub Blub](https://speechblubs.com) in:
- [Speech Blubs](https://apps.apple.com/us/app/speech-blubs-language-therapy/id1239522573)
- [Speech Blubs Pro](https://apps.apple.com/us/app/speech-blubs-pro-made-for-slps/id1669028733)

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
The upper example tells Coordinator that the view controller considers itself completed. It is up to Coordinator to do any other actions, open new screens, etc.

## Establishing Coordinators in your app

How 

```swift

```


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


# SwiftUI Support

# UIKit Support

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
