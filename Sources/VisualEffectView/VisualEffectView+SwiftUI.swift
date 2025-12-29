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
 
 This view uses the `VisualEffectView` class to create blur and glass effects.
 
 ## Usage
 
 Style-based (recommended):
 ```swift
 VisualEffect(style: .systemBlur(.dark))
 VisualEffect(style: .glass(.regular))
 ```
 
 Legacy customizable blur:
 ```swift
 VisualEffect(colorTint: .white, colorTintAlpha: 0.5, blurRadius: 18)
 ```
 
 - Note: Blur parameters (colorTint, blurRadius, etc.) only apply to `.customBlur` style.
 */
public struct VisualEffect: UIViewRepresentable {
    public typealias VisualEffectStyle = VisualEffectView.VisualEffectStyle
    
    // MARK: - Style
    
    /// Optional high-level style selector.
    /// If `nil`, the legacy customizable blur pipeline is used for backward compatibility.
    let style: VisualEffectStyle?
    
    // MARK: - Blur parameters (customBlur only)
    
    let colorTint: Color?
    let colorTintAlpha: CGFloat
    let blurRadius: CGFloat
    let saturation: CGFloat
    let scale: CGFloat
    
    // MARK: - Initializers
    
    /**
     Style-based initializer (recommended).
     
     Use this for system blur, glass effects, or explicit custom blur.
     
     - Parameter style: The visual effect style to apply.
     
     ## Example
     ```swift
     VisualEffect(style: .systemBlur(.dark))
     VisualEffect(style: .glass(.regular))
     VisualEffect(style: .customBlur)
     ```
     */
    public init(style: VisualEffectStyle) {
        self.style = style
        self.colorTint = nil
        self.colorTintAlpha = 0
        self.blurRadius = 0
        self.saturation = 1
        self.scale = 1
    }
    
    /**
     Legacy customizable blur initializer.
     
     Uses the customizable blur pipeline with fine-grained control over blur parameters.
     Maintained for backward compatibility.
     
     - Parameters:
       - colorTint: Optional tint color overlay
       - colorTintAlpha: Alpha value for the tint color (0.0 - 1.0)
       - blurRadius: Blur intensity in points
       - saturation: Color saturation multiplier (1.0 = original, >1.0 = more saturated, <1.0 = less saturated)
       - scale: Scale factor for the blur effect
     
     ## Example
     ```swift
     VisualEffect(
         colorTint: .white,
         colorTintAlpha: 0.5,
         blurRadius: 18,
         saturation: 1.8
     )
     ```
     */
    public init(
        colorTint: Color? = nil,
        colorTintAlpha: CGFloat = 0,
        blurRadius: CGFloat = 0,
        saturation: CGFloat = 1,
        scale: CGFloat = 1
    ) {
        self.style = nil  // nil signals legacy mode
        self.colorTint = colorTint
        self.colorTintAlpha = colorTintAlpha
        self.blurRadius = blurRadius
        self.saturation = saturation
        self.scale = scale
    }
    
    // MARK: - UIViewRepresentable
    
    public func makeUIView(context: Context) -> VisualEffectView {
        let view = VisualEffectView()
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        if let style {
            view.style = style
        }
        // else: keep view's default (.customBlur) for backward compatibility
        
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
        // Only apply these parameters when using the custom blur pipeline
        // (either explicitly via style or implicitly via legacy init)
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

// MARK: - Preview

#Preview("Custom Blur") {
    ZStack {
        LinearGradient(
            colors: [.blue, .purple],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        .ignoresSafeArea()
        
        Color.red
            .frame(width: 200, height: 100)
        
        VisualEffect(
            colorTint: .green,
            colorTintAlpha: 0.5,
            blurRadius: 18,
            saturation: 2.0
        )
        .frame(width: 300, height: 200)
        .cornerRadius(20)
    }
}

#Preview("System Blur") {
    ZStack {
        Image(systemName: "sparkles")
            .font(.system(size: 200))
            .foregroundStyle(.blue)
        
        VStack(spacing: 20) {
            Text("System Blur")
                .font(.title)
            
            VisualEffect(style: .systemBlur(.systemMaterial))
                .frame(width: 300, height: 100)
                .cornerRadius(16)
                .overlay {
                    Text("Content over blur")
                        .font(.headline)
                }
        }
    }
}

@available(iOS 17.0, *)
#Preview("Glass Effect", traits: .fixedLayout(width: 400, height: 400)) {
    ZStack {
        LinearGradient(
            colors: [.orange, .pink],
            startPoint: .top,
            endPoint: .bottom
        )
        .ignoresSafeArea()
        
        VStack(spacing: 20) {
            if #available(iOS 26.0, *) {
                Text("Glass Effect (iOS 26+)")
                    .font(.title3)
                
                VisualEffect(style: .glass(.regular))
                    .frame(width: 300, height: 100)
                    .cornerRadius(20)
                    .overlay {
                        Text("Regular Glass")
                    }
                
                VisualEffect(style: .glass(.clear))
                    .frame(width: 300, height: 100)
                    .cornerRadius(20)
                    .overlay {
                        Text("Clear Glass")
                    }
            } else {
                Text("Glass Effect")
                    .font(.title3)
                Text("(Fallback on iOS < 26)")
                    .font(.caption)
                
                VisualEffect(style: .glass(.regular))
                    .frame(width: 300, height: 100)
                    .cornerRadius(20)
                    .overlay {
                        Text("Regular Glass Fallback")
                    }
            }
        }
    }
}

// MARK: - Color Extension

private extension Color {
    func uiColor() -> UIColor {
        return UIColor(self)
    }
}
