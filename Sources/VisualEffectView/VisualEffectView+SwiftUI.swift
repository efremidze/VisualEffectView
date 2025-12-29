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
    /**
     The tint color to apply to the blur effect.
     
     The default value is `nil`.
     */
    let colorTint: Color?

    /**
     The alpha component of the tint color.
     
     The default value is `0.0`.
     */
    let colorTintAlpha: CGFloat

    /**
     The radius of the blur effect.
     
     The default value is `0.0`.
     */
    let blurRadius: CGFloat

    /**
     The saturation factor.
     
     Values above 1.0 increase saturation, values below 1.0 decrease saturation, and 1.0 maintains original saturation.
     
     The default value is `1.0`.
     */
    let saturation: CGFloat

    /**
     The scale factor for the blur effect.
     
     The default value is `1.0`.
     */
    let scale: CGFloat
    
    @available(iOS 26.0, *)
    public var glassTintColor: UIColor?

    @available(iOS 26.0, *)
    public var isGlassInteractive: Bool

    /**
     Initializes a `VisualEffect` view with the specified parameters.
     
     - Parameters:
        - colorTint: The tint color to apply to the blur effect. Defaults to `nil`.
        - colorTintAlpha: The alpha component of the tint color. Defaults to `0.0`.
        - blurRadius: The radius of the blur effect. Defaults to `0.0`.
        - saturation: The saturation adjustment factor. Values above 1.0 increase saturation, values below 1.0 decrease saturation. Defaults to `1.0`.
        - scale: The scale factor for the blur effect. Defaults to `1.0`.
     */
    public init(colorTint: Color? = nil, colorTintAlpha: CGFloat = 0, blurRadius: CGFloat = 0, saturation: CGFloat = 1, scale: CGFloat = 1) {
        self.colorTint = colorTint
        self.colorTintAlpha = colorTintAlpha
        self.blurRadius = blurRadius
        self.saturation = saturation
        self.scale = scale
    }

    @available(iOS 26.0, *)
    public init(glass: GlassStyle, tint: UIColor? = nil, interactive: Bool = false) {
        self.glass = glass
        self.tint = tint
        self.interactive = interactive
    }
    
    public func makeUIView(context: Context) -> VisualEffectView {
        let view = VisualEffectView()
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        if let colorTint {
            view.colorTint = colorTint.uiColor()
        }
        view.colorTintAlpha = colorTintAlpha
        view.blurRadius = blurRadius
        view.saturation = saturation
        view.scale = scale
        
        return view
    }
    
    public func updateUIView(_ uiView: VisualEffectView, context: Context) {
        if let colorTint {
            uiView.colorTint = colorTint.uiColor()
        }
        uiView.colorTintAlpha = colorTintAlpha
        uiView.blurRadius = blurRadius
        uiView.saturation = saturation
        uiView.scale = scale
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
