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
    
    /// The visual effect view's tint color.
    public var colorTint: UIColor {
        get { return _valueForKey("colorTint") as! UIColor }
        set { _setValue(newValue, forKey: "colorTint") }
    }
    
    /// The visual effect view's tint color alpha.
    public var colorTintAlpha: CGFloat {
        get { return _valueForKey("colorTintAlpha") as! CGFloat }
        set { _setValue(newValue, forKey: "colorTintAlpha") }
    }
    
    /// The visual effect view's blur radius.
    public var blurRadius: CGFloat {
        get { return _valueForKey("blurRadius") as! CGFloat }
        set { _setValue(newValue, forKey: "blurRadius") }
    }
    
    /// The visual effect view's scale factor.
    public var scale: CGFloat {
        get { return _valueForKey("scale") as! CGFloat }
        set { _setValue(newValue, forKey: "scale") }
    }
    
    // ["grayscaleTintLevel", "grayscaleTintAlpha", "lightenGrayscaleWithSourceOver", "colorTint", "colorTintAlpha", "colorBurnTintLevel", "colorBurnTintAlpha", "darkeningTintAlpha", "darkeningTintHue", "darkeningTintSaturation", "darkenWithSourceOver", "blurRadius", "saturationDeltaFactor", "scale", "zoom"]
    
}

extension VisualEffectView {
    
    func _valueForKey(key: String) -> AnyObject? {
        return blurEffect.valueForKeyPath(key)
    }
    
    func _setValue(value: AnyObject?, forKey key: String) {
        blurEffect.setValue(value, forKeyPath: key)
        self.effect = blurEffect
    }
    
}
