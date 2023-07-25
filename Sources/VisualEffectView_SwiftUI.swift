//
//  VisualEffectView_SwiftUI.swift
//  VisualEffectView
//
//  Created by 朱浩宇 on 2023/5/10.
//  Copyright © 2023 Lasha Efremidze. All rights reserved.
//

import SwiftUI

@available(iOS 14, *)
public struct VisualEffect: UIViewRepresentable {
    let colorTint: Color?
    let colorTintAlpha: CGFloat
    let blurRadius: CGFloat
    let scale: CGFloat
    
    public init(colorTint: Color? = nil, colorTintAlpha: CGFloat = 0, blurRadius: CGFloat = 0, scale: CGFloat = 1) {
        self.colorTint = colorTint
        self.colorTintAlpha = colorTintAlpha
        self.blurRadius = blurRadius
        self.scale = scale
    }
    
    public func makeUIView(context: Context) -> VisualEffectView {
        let view = VisualEffectView()
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        if let colorTint {
            view.colorTint = colorTint.uiColor()
        }
        view.colorTintAlpha = colorTintAlpha
        view.blurRadius = blurRadius
        view.scale = scale
        
        return view
    }
    
    public func updateUIView(_ uiView: VisualEffectView, context: Context) {
        if let colorTint {
            uiView.colorTint = colorTint.uiColor()
        }
        uiView.colorTintAlpha = colorTintAlpha
        uiView.blurRadius = blurRadius
        uiView.scale = scale
    }
}

@available(iOS 14, *)
struct VisualEffect_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.blue
                .frame(width: 400, height: 400)
            Color.red
                .frame(width: 200, height: 100)
            VisualEffect(colorTint: .white, colorTintAlpha: 0.5, blurRadius: 18)
                .frame(width: 300, height: 200)
        }
    }
}

@available(iOS 14, *)
private extension Color {
    func uiColor() -> UIColor {
        return UIColor(self)
    }
}
