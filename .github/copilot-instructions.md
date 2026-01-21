# VisualEffectView iOS Library

VisualEffectView is a dynamic blur background view with tint color (UIVisualEffectView subclass) for iOS 14.0+ written in Swift 5.9+. It supports SwiftUI and has distribution via Swift Package Manager, CocoaPods, and Carthage.

**Always reference these instructions first and fallback to search or bash commands only when you encounter unexpected information that does not match the info here.**

## CRITICAL: Platform Requirements

**This codebase ONLY builds and runs on macOS with Xcode installed. It cannot be built on Linux environments.**

- **REQUIRED**: macOS with Xcode compatible with Swift 5.9+
- **REQUIRED**: iOS 14.0+ for deployment target
- Build tools: `xcodebuild`, Swift Package Manager, CocoaPods, Carthage
- Validation tools: SwiftLint

## Working Effectively

### Bootstrap and Environment Setup
- **REQUIRED**: Install Xcode from Mac App Store or developer.apple.com
- **REQUIRED**: Install command line tools: `xcode-select --install`
- Install SwiftLint: `brew install swiftlint`
- Install CocoaPods: `sudo gem install cocoapods`
- Install Carthage: `brew install carthage`

### Building the Library
**NEVER CANCEL: All build commands require patience. Use 60+ minute timeouts.**

#### Swift Package Manager
- Basic build: `swift build --triple arm64-apple-ios14.0 --sdk $(xcrun --sdk iphoneos --show-sdk-path)`
- Build time: ~30-60 seconds on modern Mac. NEVER CANCEL - set timeout to 300+ seconds.

#### Xcode Project
- Build library: `xcodebuild -project "VisualEffectView.xcodeproj" -scheme "VisualEffectView" -sdk iphoneos CODE_SIGNING_ALLOWED=NO clean build`
- Build Example app: `xcodebuild -project "VisualEffectView.xcodeproj" -scheme "Example" -sdk iphonesimulator CODE_SIGNING_ALLOWED=NO clean build`
- Build time: ~2-5 minutes depending on clean state. NEVER CANCEL - set timeout to 600+ seconds.

#### Alternative: Open in Xcode
- Open `VisualEffectView.xcodeproj` in Xcode
- Select "Example" scheme and iOS Simulator
- Press Cmd+B to build or Cmd+R to run

### Validation and Testing

#### SwiftLint (Required before commits)
- Run linting: `swiftlint lint`
- **Timing**: 15-30 seconds. NEVER CANCEL - set timeout to 60+ seconds.
- **CRITICAL**: Code must pass SwiftLint validation or CI will fail.

#### CocoaPods Validation
- Validate podspec: `pod lib lint VisualEffectView.podspec --allow-warnings`
- **Timing**: 30-120 seconds depending on network. NEVER CANCEL - set timeout to 300+ seconds.
- **Note**: Requires `--allow-warnings` flag due to documentation URL warning.

#### Manual Functionality Testing (REQUIRED)
**ALWAYS test these scenarios after making changes:**

1. **Build and Run Example App**:
   - Open Example app in iOS Simulator
   - Verify the blur effect grid displays correctly
   - Test the blur radius slider - effects should change in real-time
   - Take a screenshot to verify visual output
   - **Timing**: 2-3 minutes to build and launch. NEVER CANCEL - set timeout to 600+ seconds.

2. **SwiftUI Integration Test**:
   - Verify VisualEffect SwiftUI view renders properly
   - Test with different colorTint values (red, blue, green, etc.)
   - Test colorTintAlpha values from 0.0 to 1.0
   - Test blurRadius values from 0 to 20

3. **UIKit Integration Test**:
   - Create a simple UIKit app that uses VisualEffectView directly
   - Test programmatic creation and property changes
   - Verify dynamic property updates work correctly

### Common Commands Reference

#### Repository Structure
```
VisualEffectView/
├── .github/                  # CI workflows and templates
│   ├── workflows/
│   │   ├── ci.yml           # Xcode build validation
│   │   ├── lint.yml         # SwiftLint validation  
│   │   └── swift.yml        # Swift Package Manager build
├── Example/                  # SwiftUI example app
│   ├── ContentView.swift    # Main demo interface
│   └── ExampleApp.swift     # App entry point
├── Sources/                  # Library source code
│   ├── VisualEffectView.swift        # Main UIKit implementation
│   ├── VisualEffectView+SwiftUI.swift # SwiftUI wrapper
│   └── UIViewEffectView+Helpers.swift # Private API helpers
├── Package.swift             # Swift Package Manager config
├── VisualEffectView.podspec  # CocoaPods config
├── .swiftlint.yml           # SwiftLint configuration
└── VisualEffectView.xcodeproj # Xcode project
```

#### Quick Development Workflow
1. `git checkout -b feature/your-feature-name`
2. Make changes to source files in `Sources/`
3. `swiftlint lint` - verify no style violations
4. `xcodebuild -project "VisualEffectView.xcodeproj" -scheme "Example" -sdk iphonesimulator CODE_SIGNING_ALLOWED=NO clean build` - verify Example builds
5. Launch Example in iOS Simulator and test functionality
6. `pod lib lint VisualEffectView.podspec --allow-warnings` - verify CocoaPods compatibility
7. Commit and push changes

#### CI Pipeline Commands (for reference)
- SwiftLint: `swiftlint lint` (~15 seconds)
- Xcode build: `xcodebuild -project "VisualEffectView.xcodeproj" -scheme "Example" CODE_SIGNING_ALLOWED=NO clean build` (~2-5 minutes)
- Swift Package: `swift build --triple arm64-apple-ios14.0 --sdk $(xcrun --sdk iphoneos --show-sdk-path)` (~30-60 seconds)

## Distribution and Release

### Swift Package Manager
- Package configuration: `Package.swift`
- Platform: iOS 14.0+
- Swift version: 5.9+

### CocoaPods  
- Podspec: `VisualEffectView.podspec`
- Version: 5.0.0
- Installation: `pod "VisualEffectView"`

### Carthage
- Installation: `github "efremidze/VisualEffectView"`
- Framework: `VisualEffectView.framework`

## Troubleshooting

### Build Failures
- **UIKit not found**: You're on Linux - this library requires macOS with Xcode
- **xcodebuild not found**: Install Xcode and command line tools
- **Signing errors**: Add `CODE_SIGNING_ALLOWED=NO` to xcodebuild commands
- **Simulator not found**: Launch Xcode and install iOS Simulator components

### SwiftLint Failures
- **swiftlint not found**: Install with `brew install swiftlint`
- **Style violations**: Fix issues or update `.swiftlint.yml` if justified
- **Disabled rules**: Current config disables force_cast, identifier_name, line_length, trailing_whitespace

### Runtime Issues
- **Blur effect not working**: This library uses private UIKit APIs - test on device/simulator, not just build validation
- **SwiftUI preview crashes**: Ensure iOS 14.0+ deployment target in hosting app
- **Performance issues**: Blur effects are GPU-intensive - test on real devices

## Important Notes

- **Private API Usage**: This library uses private UIKit APIs (`_UICustomBlurEffect`, `_UIVisualEffectBackdropView`) for enhanced blur effects
- **App Store Risk**: Apple may reject apps using private APIs - use with caution in production
- **iOS Version Support**: Only supports iOS 14.0+ due to API dependencies
- **No Unit Tests**: Validation relies on manual testing with Example app and visual verification
- **Documentation**: API documentation generated with Jazzy, available at https://efremidze.github.io/VisualEffectView/

**Remember**: Always validate changes by running the Example app and testing visual effects functionality. Screenshots of the working app are the best validation that changes work correctly.