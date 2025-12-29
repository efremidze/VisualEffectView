# VisualEffectView

[![CI](https://github.com/efremidze/VisualEffectView/actions/workflows/ci.yml/badge.svg)](https://github.com/efremidze/VisualEffectView/actions/workflows/ci.yml)
[![CocoaPods](https://img.shields.io/cocoapods/v/VisualEffectView.svg)](https://cocoapods.org/pods/VisualEffectView)
[![Carthage](https://img.shields.io/badge/Carthage-compatible-brightgreen.svg)](https://github.com/Carthage/Carthage)
[![SPM](https://img.shields.io/badge/SPM-compatible-brightgreen.svg)](https://swift.org/package-manager/)
[![Swift](https://img.shields.io/badge/Swift-5.9+-orange.svg)](https://swift.org)
[![License](https://img.shields.io/github/license/efremidze/VisualEffectView.svg)](https://github.com/efremidze/VisualEffectView/blob/master/LICENSE)

**VisualEffectView** is a dynamic blur effect library with tint color support and iOS 26+ glass effects. This library uses [UIVisualEffectView](https://developer.apple.com/library/ios/documentation/UIKit/Reference/UIVisualEffectView/) to generate the blur.

<img src="/Images/demo.gif" width="250" />

```
$ pod try VisualEffectView
```

## Requirements

- iOS 14.0+
- Swift 5 (VisualEffectView 4.x), Swift 4 (VisualEffectView 3.x), Swift 3 (VisualEffectView 2.x), Swift 2 (VisualEffectView 1.x)
- Supports SwiftUI

## Usage

### UIKit

```swift
import VisualEffectView

let visualEffectView = VisualEffectView(frame: CGRect(x: 0, y: 0, width: 320, height: 480))

// Customize the blur
visualEffectView.colorTint = .red
visualEffectView.colorTintAlpha = 0.2
visualEffectView.blurRadius = 10
visualEffectView.scale = 1

addSubview(visualEffectView)
```

You can also use different styles:

```swift
// System blur
visualEffectView.style = .systemBlur(.dark)

// Glass effect (iOS 26+)
visualEffectView.style = .glass(.regular)

// Custom blur (default)
visualEffectView.style = .customBlur
```

### SwiftUI

```swift
import VisualEffectView

struct ContentView: View {
    var body: some View {
        VisualEffect(colorTint: .white, colorTintAlpha: 0.5, blurRadius: 18, scale: 1)
    }
}
```

Or use the style-based API:

```swift
VisualEffect(style: .glass(.regular))
VisualEffect(style: .systemBlur(.dark))
```

### Customization

```swift
var colorTint: UIColor // tint color. default is nil
var colorTintAlpha: CGFloat // tint color alpha. default is 0
var blurRadius: CGFloat // blur radius. default is 0
var scale: CGFloat // scale factor. default is 1
var saturation: CGFloat // saturation factor. default is 1
```

**Note:** Custom blur properties only work when `style` is `.customBlur`.

If you want `colorTintAlpha` to be different from `0`, make sure you always set it right after setting the `colorTint` or it may not be applied as expected. Don't set `colorTintAlpha` if `colorTint` is `nil`.

### Content View

Add subviews to the `contentView` property, not directly to the visual effect view:

```swift
visualEffectView.contentView.addSubview(label)
```

Refer to the [UIVisualEffectView](https://developer.apple.com/library/ios/documentation/UIKit/Reference/UIVisualEffectView/) documentation for more info.

### Storyboard Support

Works great with storyboards and xibs.

## Installation

### CocoaPods
To install with [CocoaPods](http://cocoapods.org/), simply add this in your `Podfile`:
```ruby
use_frameworks!
pod "VisualEffectView"
```

### Carthage
To install with [Carthage](https://github.com/Carthage/Carthage), simply add this in your `Cartfile`:
```ruby
github "efremidze/VisualEffectView"
```

### Swift Package Manager
Add VisualEffectView as a dependency in your `Package.swift` file:
```swift
dependencies: [
    .package(url: "https://github.com/efremidze/VisualEffectView.git", from: "5.0.0")
]
```

### Manually
1. Download and drop the source files in your project.  
2. Congratulations!

## Communication

- If you **found a bug**, open an issue.
- If you **have a feature request**, open an issue.
- If you **want to contribute**, submit a pull request.

## Disclaimer

VisualEffectView utilizes a private UIKit API to do its magic. Use caution, submitting this code to the App Store adds the risk of being rejected!

The `.systemBlur()` and `.glass()` styles use only public APIs and are safe for App Store submission.

## Credits

https://github.com/collinhundley/APCustomBlurView

## License

VisualEffectView is available under the MIT license. See the LICENSE file for more info.
