//
//  VisualEffectView.swift
//  VisualEffectView
//
//  Created by Lasha Efremidze on 5/26/16.
//  Copyright © 2016 Lasha Efremidze. All rights reserved.
//

import UIKit

/// VisualEffectView is a dynamic background blur view.
///
/// ## Usage
/// ```swift
/// // Legacy customizable blur (default for backward compatibility)
/// let view = VisualEffectView()
/// view.blurRadius = 20
/// view.colorTint = .white
///
/// // Style-based API
/// let systemView = VisualEffectView()
/// systemView.style = .systemBlur(.dark)
///
/// // Glass effect (iOS 26+)
/// let glassView = VisualEffectView()
/// glassView.style = .glass(.regular)
/// ```
///
/// - Note: Custom blur properties (blurRadius, colorTint, etc.) only apply when using `.customBlur` style.
@MainActor
@objcMembers
open class VisualEffectView: UIVisualEffectView {
    
    /// Returns the instance of UIBlurEffect.
    private let blurEffect = (NSClassFromString("_UICustomBlurEffect") as! UIBlurEffect.Type).init()
    
    // MARK: - Public Style API
    
    public enum VisualEffectStyle: Sendable, Equatable {
        case none
        case systemBlur(UIBlurEffect.Style)
        case customBlur
        case glass(GlassStyle) // iOS 26+
    }
    
    public enum GlassStyle: Sendable, Equatable {
        case regular
        case clear
        
        @available(iOS 26.0, *)
        fileprivate var uiStyle: UIGlassEffect.Style {
            switch self {
            case .regular: return .regular
            case .clear: return .clear
            }
        }
        
        /// Fallback blur style for iOS < 26
        fileprivate var fallbackBlurStyle: UIBlurEffect.Style {
            switch self {
            case .regular: return .systemMaterial
            case .clear: return .systemUltraThinMaterial
            }
        }
    }
    
    /// High-level switch for the backing material.
    /// Default is `.customBlur` for backward compatibility.
    ///
    /// - Note: When using `.systemBlur` or `.glass`, custom blur properties
    ///   (blurRadius, colorTint, etc.) are ignored.
    public var style: VisualEffectStyle = .customBlur {
        didSet {
            guard style != oldValue else { return }
            applyStyle(style)
        }
    }
    
    // MARK: - Preserve custom settings across style switches
    
    private struct CustomSnapshot {
        var colorTint: UIColor?
        var blurRadius: CGFloat
        var saturation: CGFloat
        var scale: CGFloat
    }
    
    private var customSnapshot = CustomSnapshot(
        colorTint: nil,
        blurRadius: 0,
        saturation: 1,
        scale: 1
    )
    
    // MARK: - Custom Blur Properties
    
    /**
     Tint color.
     
     - Note: Only applies when `style` is `.customBlur`.
     The default value is nil.
     */
    open var colorTint: UIColor? {
        get {
            return sourceOver?.value(forKeyPath: "color") as? UIColor
        }
        set {
            customSnapshot.colorTint = newValue
            guard case .customBlur = style else { return }
            
            prepareForChanges()
            sourceOver?.setValue(newValue, forKeyPath: "color")
            sourceOver?.perform(Selector(("applyRequestedEffectToView:")), with: overlayView)
            applyChanges()
            overlayView?.backgroundColor = newValue
        }
    }
    
    /**
     Tint color alpha.
     
     - Note: Only applies when `style` is `.customBlur`.
     Don't use it unless `colorTint` is not nil.
     The default value is 0.0.
     */
    open var colorTintAlpha: CGFloat {
        get { return _value(forKey: .colorTintAlpha) ?? 0.0 }
        set { colorTint = colorTint?.withAlphaComponent(newValue) }
    }
    
    /**
     Blur radius.
     
     - Note: Only applies when `style` is `.customBlur`.
     The default value is 0.0.
     */
    open var blurRadius: CGFloat {
        get {
            return gaussianBlur?.requestedValues?["inputRadius"] as? CGFloat ?? 0
        }
        set {
            customSnapshot.blurRadius = newValue
            guard case .customBlur = style else { return }
            
            prepareForChanges()
            gaussianBlur?.requestedValues?["inputRadius"] = newValue
            applyChanges()
        }
    }
    
    /**
     Saturation factor.
     
     Values above 1.0 increase saturation, values below 1.0 decrease saturation, and 1.0 maintains original saturation.
     
     - Note: Only applies when `style` is `.customBlur`.
     The default value is 1.0.
     */
    open var saturation: CGFloat {
        get { return _value(forKey: .saturationDeltaFactor) ?? 1.0 }
        set {
            customSnapshot.saturation = newValue
            guard case .customBlur = style else { return }
            
            _setValue(newValue, forKey: .saturationDeltaFactor)
        }
    }
    
    /**
     Scale factor.
     
     The scale factor determines how content in the view is mapped from the logical coordinate space (measured in points) to the device coordinate space (measured in pixels).
     
     - Note: Only applies when `style` is `.customBlur`.
     The default value is 1.0.
     */
    open var scale: CGFloat {
        get { return _value(forKey: .scale) ?? 1.0 }
        set {
            customSnapshot.scale = newValue
            guard case .customBlur = style else { return }
            
            _setValue(newValue, forKey: .scale)
        }
    }
    
    // MARK: - Initialization
    
    /// Creates a visual effect view with customizable blur (legacy default for backward compatibility).
    public convenience init() {
        self.init(effect: nil)
    }
    
    public override init(effect: UIVisualEffect?) {
        super.init(effect: effect)
        
        // If no effect provided, use legacy default for backward compatibility
        if effect == nil {
            applyStyle(.customBlur)
        }
        // Otherwise, respect the passed effect
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        // Interface Builder instances default to custom blur
        applyStyle(.customBlur)
    }
    
}

// MARK: - Style

private extension VisualEffectView {
    
    func applyStyle(_ style: VisualEffectStyle) {
        switch style {
        case .none:
            self.effect = nil
            
        case .systemBlur(let style):
            self.effect = UIBlurEffect(style: style)
            
        case .customBlur:
            // Switch back to custom effect object
            self.effect = blurEffect
            // Re-apply settings snapshot so switching styles is reversible
            reapplyCustomSnapshot()
            
        case .glass(let glass):
            if #available(iOS 26.0, *) {
                self.effect = UIGlassEffect(style: glass.uiStyle)
            } else {
                // Graceful fallback on older OS with style-appropriate blur
                self.effect = UIBlurEffect(style: glass.fallbackBlurStyle)
            }
        }
    }
    
    func reapplyCustomSnapshot() {
        // Apply in a safe order; these call into the existing custom pipeline
        self.scale = customSnapshot.scale
        self.saturation = customSnapshot.saturation
        self.blurRadius = customSnapshot.blurRadius
        self.colorTint = customSnapshot.colorTint
    }
    
}

// MARK: - Helpers

private extension VisualEffectView {
    
    /// Returns the value for the key on the blurEffect.
    func _value<T>(forKey key: Key) -> T? {
        return blurEffect.value(forKeyPath: key.rawValue) as? T
    }
    
    /// Sets the value for the key on the blurEffect.
    func _setValue<T>(_ value: T?, forKey key: Key) {
        blurEffect.setValue(value, forKeyPath: key.rawValue)
    }
    
    enum Key: String {
        case colorTint, colorTintAlpha, blurRadius, saturationDeltaFactor, scale
    }
    
}

// Available keys for reference:
// ["grayscaleTintLevel", "grayscaleTintAlpha", "lightenGrayscaleWithSourceOver", "colorTint", "colorTintAlpha", "colorBurnTintLevel", "colorBurnTintAlpha", "darkeningTintAlpha", "darkeningTintHue", "darkeningTintSaturation", "darkenWithSourceOver", "blurRadius", "saturationDeltaFactor", "scale", "zoom"]
