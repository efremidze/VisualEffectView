//
//  ContentView.swift
//  Example
//
//  Created by Lasha Efremidze on 8/14/25.
//  Copyright © 2025 Lasha Efremidze. All rights reserved.
//

import SwiftUI
import VisualEffectView

struct ContentView: View {
    @State private var blurRadius: CGFloat = 0
    
    var body: some View {
        ZStack(alignment: .bottom) {
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                ForEach(Color.colors, id: \.self) { color in
                    ZStack {
                        Image(systemName: "swift")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 100)
                            .foregroundStyle(.black)
                        
                        VisualEffect(
                            colorTint: color,
                            colorTintAlpha: 0.5,
                            blurRadius: blurRadius
                        )
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            VStack {
                Slider(value: $blurRadius, in: 0...20)
                
                Text("Slide to blur")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            .padding(.horizontal, 32)
            .padding(.bottom, 32)
        }
    }
}

private extension Color {
    static let colors = [red, orange, yellow, green, teal, blue, purple, pink]
}

#Preview {
    ContentView()
}

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
