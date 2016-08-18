//
//  VisualEffectView.swift
//  VisualEffectView
//
//  Created by Lasha Efremidze on 5/26/16.
//  Copyright © 2016 Lasha Efremidze. All rights reserved.
//

import UIKit

public class VisualEffectView: UIVisualEffectView {
    
    let blurEffect = (NSClassFromString("_UICustomBlurEffect") as! UIBlurEffect.Type).init()
    
    /// Tint color.
    public var colorTint: UIColor {
        get { return _valueForKey("colorTint") as! UIColor }
        set { _setValue(newValue, forKey: "colorTint") }
    }
    
    /// Tint color alpha.
    public var colorTintAlpha: CGFloat {
        get { return _valueForKey("colorTintAlpha") as! CGFloat }
        set { _setValue(newValue as AnyObject?, forKey: "colorTintAlpha") }
    }
    
    /// Blur radius.
    public var blurRadius: CGFloat {
        get { return _valueForKey("blurRadius") as! CGFloat }
        set { _setValue(newValue as AnyObject?, forKey: "blurRadius") }
    }
    
    /// Scale factor.
    public var scale: CGFloat {
        get { return _valueForKey("scale") as! CGFloat }
        set { _setValue(newValue as AnyObject?, forKey: "scale") }
    }
    
    // ["grayscaleTintLevel", "grayscaleTintAlpha", "lightenGrayscaleWithSourceOver", "colorTint", "colorTintAlpha", "colorBurnTintLevel", "colorBurnTintAlpha", "darkeningTintAlpha", "darkeningTintHue", "darkeningTintSaturation", "darkenWithSourceOver", "blurRadius", "saturationDeltaFactor", "scale", "zoom"]
    
}

extension VisualEffectView {
    
    func _valueForKey(_ key: String) -> AnyObject? {
        return blurEffect.value(forKeyPath: key) as AnyObject?
    }
    
    func _setValue(_ value: AnyObject?, forKey key: String) {
        blurEffect.setValue(value, forKeyPath: key)
        self.effect = blurEffect
    }
    
}
