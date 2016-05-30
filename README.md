# VisualEffectView

[![Twitter](https://img.shields.io/badge/Twitter-@lasha_-blue.svg?style=flat)](http://twitter.com/lasha_)
[![Version](https://img.shields.io/cocoapods/v/VisualEffectView.svg?style=flat)](http://cocoapods.org/pods/VisualEffectView)
[![CI Status](http://img.shields.io/travis/efremidze/VisualEffectView.svg?style=flat)](https://travis-ci.org/efremidze/VisualEffectView)
[![codebeat badge](https://codebeat.co/badges/333beeda-5948-42f3-8775-0e3626408a82)](https://codebeat.co/projects/github-com-efremidze-visualeffectview)

UIVisualEffectView subclass with tint color.

![Preview](preview.png)

```
$ pod try VisualEffectView
```

## Installation
###CocoaPods
To install with [CocoaPods](http://cocoapods.org/), simply add this in your `Podfile`:
```ruby
use_frameworks!
pod "VisualEffectView"
```

###Carthage
To install with [Carthage](https://github.com/Carthage/Carthage), simply add this in your `Cartfile`:
```ruby
github "efremidze/VisualEffectView"
```

## Usage

VisualEffectView is a UIVisualEffectView subclass.

```swift
import VisualEffectView

let visualEffectView = VisualEffectView()
visualEffectView.colorTint = .redColor()
visualEffectView.colorTintAlpha = 0.5
visualEffectView.blurRadius = 20
addSubview(visualEffectView)
```

### Customization
```swift
var colorTint: UIColor // tint color
var colorTintAlpha: CGFloat // tint color alpha
var blurRadius: CGFloat // blur radius
var scale: CGFloat // scale factor
```

## Contributions

Contributions are totally welcome.

## License

VisualEffectView is available under the MIT license. See the LICENSE file for more info.
