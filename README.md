# VisualEffectView

[![CI](https://github.com/efremidze/VisualEffectView/actions/workflows/ci.yml/badge.svg)](https://github.com/efremidze/VisualEffectView/actions/workflows/ci.yml)
[![CocoaPods](https://img.shields.io/cocoapods/v/VisualEffectView.svg)](https://cocoapods.org/pods/VisualEffectView)
[![Carthage](https://img.shields.io/badge/Carthage-compatible-brightgreen.svg)](https://github.com/Carthage/Carthage)
[![SPM](https://img.shields.io/badge/SPM-compatible-brightgreen.svg)](https://swift.org/package-manager/)
[![Swift](https://img.shields.io/badge/Swift-5.9+-orange.svg)](https://swift.org)
[![License](https://img.shields.io/github/license/efremidze/VisualEffectView.svg)](https://github.com/efremidze/VisualEffectView/blob/master/LICENSE)

**VisualEffectView** is a blur effect library with tint color support. This library uses the [UIVisualEffectView](https://developer.apple.com/library/ios/documentation/UIKit/Reference/UIVisualEffectView/) to generate the blur.

<img src="/Images/demo.gif" width="250" />

```
$ pod try VisualEffectView
```

## Requirements

- iOS 14.0+
- Swift 5 (VisualEffectView 4.x), Swift 4 (VisualEffectView 3.x), Swift 3 (VisualEffectView 2.x), Swift 2 (VisualEffectView 1.x)
- Supports SwiftUI

## Usage

Add an instance of VisualEffectView to your view.

```swift
import VisualEffectView

let visualEffectView = VisualEffectView(frame: CGRect(x: 0, y: 0, width: 320, height: 480))

// Configure the view with tint color, blur radius, etc
visualEffectView.colorTint = .redColor()
visualEffectView.colorTintAlpha = 0.2
visualEffectView.blurRadius = 10
visualEffectView.scale = 1

addSubview(visualEffectView)
```

Depending on the desired effect, the effect may affect content layered behind the view or content added to the visual effect view’s contentView. After you add the visual effect view to the view hierarchy, add any subviews to the contentView property of the visual effect view. Do not add subviews directly to the visual effect view itself. Refer to the [UIVisualEffectView](https://developer.apple.com/library/ios/documentation/UIKit/Reference/UIVisualEffectView/) for more info.

For more examples, take a look at the example project.

### Customization

```swift
var colorTint: UIColor // tint color. default is nil
var colorTintAlpha: CGFloat // tint color alpha. default is 0
var blurRadius: CGFloat // blur radius. default is 0
var scale: CGFloat // scale factor. default is 1
```

If you want `colorTintAlpha` to be different from `0`, make sure you always set it right after setting the `colorTint` or it may not be applied as expected.
You also have to make sure you don't set `colorTintAlpha` if `colorTint` is `nil`. 

### Storyboard Support

Works great with storyboards and xibs.

### SwiftUI Support

VisualEffectView supports SwiftUI.

```swift
import VisualEffectView

struct ContentView: View {
    var body: some View {
        VisualEffect(colorTint: .white, colorTintAlpha: 0.5, blurRadius: 18, scale: 1)
    }
}
```

Make sure that `colorTintAlpha` is not set when `colorTint` is `nil`.

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

### Manually
1. Download and drop ```VisualEffectView.swift``` in your project.  
2. Congratulations!

## Communication

- If you **found a bug**, open an issue.
- If you **have a feature request**, open an issue.
- If you **want to contribute**, submit a pull request.

## Disclaimer

VisualEffectView utilizes a private UIKit API to do its magic. Use caution, submitting this code to the App Store adds the risk of being rejected!

## Credits

https://github.com/collinhundley/APCustomBlurView

## License

VisualEffectView is available under the MIT license. See the LICENSE file for more info.
