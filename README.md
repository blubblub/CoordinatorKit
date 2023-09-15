# CoordinatorKit

Navigation using Coordinators in Swift for UIKit and SwiftUI apps.

It is used in production by Blub Blub in:
- Speech Blubs
- Speech Blubs Pro

# Getting Started

The base of CoordinatorKit are the following protocols:

- `CoordinatorMessagable`
- `Coordinating`
- `CoordinatorInitializable`
- `Coordinator`

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
