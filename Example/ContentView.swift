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
            
            VStack(spacing: 16) {
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
