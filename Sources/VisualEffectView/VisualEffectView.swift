//
//  VisualEffectView.swift
//  VisualEffectView
//
//  Created by Lasha Efremidze on 5/26/16.
//  Copyright © 2016 Lasha Efremidze. All rights reserved.
//

import UIKit

/// VisualEffectView is a dynamic background blur view.
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
    }
    
    /// High-level switch for the backing material.
    /// Default keeps existing behavior by using `.customBlur`.
    public var style: VisualEffectStyle = .customBlur {
        didSet { applyStyle(style) }
    }
    
    /**
     Tint color.
     
     The default value is nil.
     */
    open var colorTint: UIColor? {
        get {
            return sourceOver?.value(forKeyPath: "color") as? UIColor
        }
        set {
            prepareForChanges()
            sourceOver?.setValue(newValue, forKeyPath: "color")
            sourceOver?.perform(Selector(("applyRequestedEffectToView:")), with: overlayView)
            applyChanges()
            overlayView?.backgroundColor = newValue
        }
    }
    
    /**
     Tint color alpha.

     Don't use it unless `colorTint` is not nil.
     The default value is 0.0.
     */
    open var colorTintAlpha: CGFloat {
        get { return _value(forKey: .colorTintAlpha) ?? 0.0 }
        set { colorTint = colorTint?.withAlphaComponent(newValue) }
    }
    
    /**
     Blur radius.
     
     The default value is 0.0.
     */
    open var blurRadius: CGFloat {
        get {
            return gaussianBlur?.requestedValues?["inputRadius"] as? CGFloat ?? 0
        }
        set {
            prepareForChanges()
            gaussianBlur?.requestedValues?["inputRadius"] = newValue
            applyChanges()
        }
    }
    
    /**
     Saturation factor.
     
     Values above 1.0 increase saturation, values below 1.0 decrease saturation, and 1.0 maintains original saturation.
     
     The default value is 1.0.
     */
    open var saturation: CGFloat {
        get { return _value(forKey: .saturationDeltaFactor) ?? 1.0 }
        set { _setValue(newValue, forKey: .saturationDeltaFactor) }
    }
    
    /**
     Scale factor.
     
     The scale factor determines how content in the view is mapped from the logical coordinate space (measured in points) to the device coordinate space (measured in pixels).
     
     The default value is 1.0.
     */
    open var scale: CGFloat {
        get { return _value(forKey: .scale) ?? 1.0 }
        set { _setValue(newValue, forKey: .scale) }
    }

    // MARK: - Style property

    public var style: VisualEffectStyle = .none {
        didSet {
            apply(style: style)
        }
    }

private extension VisualEffectView {
    
    func applyStyle(_ style: VisualEffectStyle) {
        switch style {
        case .none:
            self.effect = nil
            
        case .systemBlur(let style):
            self.effect = UIBlurEffect(style: style)
            
        case .customBlur:
            // Switch back to your private/custom effect object
            self.effect = blurEffect
            // Re-apply settings snapshot so switching styles is reversible
            reapplyCustomSnapshot()
            
        case .glass(let glass):
            if #available(iOS 26.0, *) {
                self.effect = UIGlassEffect(style: glass.uiStyle) // UIKit iOS 26 API
            } else {
                // graceful fallback on older OS
                self.effect = UIBlurEffect(style: .systemThinMaterial)
            }
        }
    }
    
    func reapplyCustomSnapshot() {
        // Apply in a safe order; these call into your existing private pipeline
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

// ["grayscaleTintLevel", "grayscaleTintAlpha", "lightenGrayscaleWithSourceOver", "colorTint", "colorTintAlpha", "colorBurnTintLevel", "colorBurnTintAlpha", "darkeningTintAlpha", "darkeningTintHue", "darkeningTintSaturation", "darkenWithSourceOver", "blurRadius", "saturationDeltaFactor", "scale", "zoom"]
