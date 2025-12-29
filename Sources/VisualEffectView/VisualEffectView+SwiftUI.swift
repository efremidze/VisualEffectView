//
//  VisualEffectView+SwiftUI.swift
//  VisualEffectView
//
//  Created by Lasha Efremidze on 5/26/16.
//  Copyright © 2023 Lasha Efremidze. All rights reserved.
//

import SwiftUI

/**
 A SwiftUI view that applies a visual effect to the background of its content.
 
 This view uses the `VisualEffectView` class to create a blur effect on the background of its content.
 
 The effect can be customized with parameters such as tint color, tint alpha, blur radius, and scale.
 */
public struct VisualEffect: UIViewRepresentable {
    public
    typealias VisualEffectStyle = VisualEffectView.VisualEffectStyle
    
    // MARK: - Style
    
    /// Optional high-level style selector.
    /// If `nil`, the legacy customizable blur pipeline is used.
    let style: VisualEffectStyle?
    
    // MARK: - Blur parameters (blur-only)
    
    let colorTint: Color?
    let colorTintAlpha: CGFloat
    let blurRadius: CGFloat
    let saturation: CGFloat
    let scale: CGFloat
    
    // MARK: - Initializers
    
    /**
     Legacy initializer (unchanged).
     
     Uses the customizable blur pipeline.
     */
    public init(
        colorTint: Color? = nil,
        colorTintAlpha: CGFloat = 0,
        blurRadius: CGFloat = 0,
        saturation: CGFloat = 1,
        scale: CGFloat = 1
    ) {
        self.style = nil
        self.colorTint = colorTint
        self.colorTintAlpha = colorTintAlpha
        self.blurRadius = blurRadius
        self.saturation = saturation
        self.scale = scale
    }
    
    /**
     Style-based initializer.
     
     Use this for system blur or Liquid Glass.
     Blur-specific parameters are ignored unless the style is `.customBlur`.
     */
    public init(style: VisualEffectStyle) {
        self.style = style
        self.colorTint = nil
        self.colorTintAlpha = 0
        self.blurRadius = 0
        self.saturation = 1
        self.scale = 1
    }
    
    // MARK: - UIViewRepresentable
    
    public func makeUIView(context: Context) -> VisualEffectView {
        let view = VisualEffectView()
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        if let style {
            view.style = style
        }
        
        applyBlurParameters(to: view)
        return view
    }
    
    public func updateUIView(_ uiView: VisualEffectView, context: Context) {
        if let style {
            uiView.style = style
        }
        
        applyBlurParameters(to: uiView)
    }
    
    // MARK: - Helpers
    
    /// Applies blur-only parameters when appropriate.
    private func applyBlurParameters(to view: VisualEffectView) {
        // Only apply these knobs when using the legacy custom blur pipeline.
        guard style == nil || style == .customBlur else { return }
        
        if let colorTint {
            view.colorTint = colorTint.uiColor()
        }
        view.colorTintAlpha = colorTintAlpha
        view.blurRadius = blurRadius
        view.saturation = saturation
        view.scale = scale
    }
}

#Preview {
    ZStack {
        Color.blue
            .frame(width: 400, height: 400)
        Color.red
            .frame(width: 200, height: 100)
        VisualEffect(colorTint: .white, colorTintAlpha: 0.5, blurRadius: 18, saturation: 2.0)
            .frame(width: 300, height: 200)
    }
}

private extension Color {
    func uiColor() -> UIColor {
        return UIColor(self)
    }
}
