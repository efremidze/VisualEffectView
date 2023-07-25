//
//  VisualEffectView_SwiftUI.swift
//  VisualEffectView
//
//  Created by 朱浩宇 on 2023/5/10.
//  Copyright © 2023 Lasha Efremidze. All rights reserved.
//

import SwiftUI

@available(iOS 13, *)
@available(xrOS 1.0, *)
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

    public typealias UIViewType = VisualEffectView

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

@available(iOS 13, *)
@available(xrOS 1.0, *)
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


@available(iOS 13, *)
@available(xrOS 1.0, *)
extension Color {

    func uiColor() -> UIColor {

        if #available(iOS 14.0, *) {
            return UIColor(self)
        }

        let components = self.components()
        return UIColor(red: components.r, green: components.g, blue: components.b, alpha: components.a)
    }

    private func components() -> (r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) {

        let scanner = Scanner(string: self.description.trimmingCharacters(in: CharacterSet.alphanumerics.inverted))
        var hexNumber: UInt64 = 0
        var r: CGFloat = 0.0, g: CGFloat = 0.0, b: CGFloat = 0.0, a: CGFloat = 0.0

        let result = scanner.scanHexInt64(&hexNumber)
        if result {
            r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
            g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
            b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
            a = CGFloat(hexNumber & 0x000000ff) / 255
        }
        return (r, g, b, a)
    }
}
