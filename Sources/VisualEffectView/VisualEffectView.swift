//
//  VisualEffectView.swift
//  VisualEffectView
//
//  Created by Lasha Efremidze on 5/26/16.
//  Copyright © 2016 Lasha Efremidze. All rights reserved.
//

import UIKit

public enum VisualEffectStyle: Sendable, Equatable {
    case none
    case blur(BlurStyle)
    case glass(GlassStyle)
}

public enum BlurStyle: Sendable, Equatable {
    case system(UIBlurEffect.Style)

    /// Use your existing private blur pipeline (tint/saturation/scale/blurRadius knobs).
    /// This returns *some* blur effect to attach to `self.effect`; your existing code
    /// will continue to drive the private effect parameters.
    case custom
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

/// VisualEffectView is a dynamic background blur view.
@objcMembers
open class VisualEffectView: UIVisualEffectView {
    
    /// Returns the instance of UIBlurEffect.
    private let blurEffect = (NSClassFromString("_UICustomBlurEffect") as! UIBlurEffect.Type).init()
    
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

    func apply(style: VisualEffectStyle) {
        switch style {
        case .none:
            clearEffectWorkaroundIfNeeded()
            self.effect = nil

        case .blur(let blur):
            clearEffectWorkaroundIfNeeded()
            self.effect = makeBlurEffect(from: blur)

        case .glass(let glass):
            if #available(iOS 26.0, *) {
                // Switching from blur/custom -> glass is fine.
                self.effect = makeGlassEffect(from: glass)
            } else {
                // graceful fallback on older OS
                apply(style: .blur(.system(.systemThinMaterial)))
            }
        }
    }
    
    // MARK: - Initialization
    
    public override init(effect: UIVisualEffect?) {
        super.init(effect: effect)
        
        scale = 1
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        scale = 1
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

private extension VisualEffectView {
    func makeBlurEffect(from style: BlurStyle) -> UIVisualEffect {
        switch style {
        case .system(let uiStyle):
            return UIBlurEffect(style: uiStyle)

        case .custom:
            // Attach any UIBlurEffect; your existing private pipeline controls the look.
            // (This mirrors what you were doing in your stub.)
            return UIBlurEffect(style: .light)
        }
    }

    @available(iOS 26.0, *)
    func makeGlassEffect(from style: GlassStyle) -> UIVisualEffect {
        return UIGlassEffect(style: style.value)
    }

    /// iOS 26: Some builds have a bug where setting `effect = nil` after a `UIGlassEffect`
    /// does not remove the effect; setting an intermediate effect first works around it.
    func clearEffectWorkaroundIfNeeded() {
        guard #available(iOS 26.0, *), self.effect is UIGlassEffect else { return }
        self.effect = UIBlurEffect(style: .systemMaterial)
    }
}
