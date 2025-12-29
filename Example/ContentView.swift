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
    typealias VisualEffectStyle = VisualEffectView.VisualEffectStyle
    @State private var blurRadius: CGFloat = 18
    @State private var colorTintAlpha: CGFloat = 0.5
    @State private var saturation: CGFloat = 1.0
    
    var body: some View {
        ZStack {
            // Animated background
            AnimatedBackground()
                .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 32) {
                    // Header
                    VStack(spacing: 8) {
                        Text("VisualEffectView")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        Text("Dynamic blur effects with style-based API")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                    .padding(.top, 20)
                    
                    // Custom Blur Section
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Custom Blur")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .padding(.horizontal, 4)
                        
                        // Custom blur controls
                        VStack(alignment: .leading, spacing: 16) {
                            VStack(spacing: 12) {
                                VStack(alignment: .leading, spacing: 4) {
                                    HStack {
                                        Text("Blur Radius")
                                        Spacer()
                                        Text("\(Int(blurRadius))")
                                            .foregroundStyle(.secondary)
                                    }
                                    Slider(value: $blurRadius, in: 0...30)
                                }
                                
                                VStack(alignment: .leading, spacing: 4) {
                                    HStack {
                                        Text("Tint Alpha")
                                        Spacer()
                                        Text(String(format: "%.2f", colorTintAlpha))
                                            .foregroundStyle(.secondary)
                                    }
                                    Slider(value: $colorTintAlpha, in: 0...1)
                                }
                                
                                VStack(alignment: .leading, spacing: 4) {
                                    HStack {
                                        Text("Saturation")
                                        Spacer()
                                        Text(String(format: "%.2f", saturation))
                                            .foregroundStyle(.secondary)
                                    }
                                    Slider(value: $saturation, in: 0...3)
                                }
                            }
                        }
                        .padding()
                        .background {
                            RoundedRectangle(cornerRadius: 16)
                                .fill(.ultraThinMaterial)
                        }
                        
                        // Custom blur demo
                        DemoCard(
                            title: "Custom Blur",
                            style: .customBlur,
                            colorTint: .white,
                            colorTintAlpha: colorTintAlpha,
                            blurRadius: blurRadius,
                            saturation: saturation
                        )
                        
                        // Color tint examples
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Color Tint Examples")
                                .font(.headline)
                                .padding(.horizontal, 4)
                            
                            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                                ForEach([
                                    ("Red", Color.red),
                                    ("Blue", Color.blue),
                                    ("Green", Color.green),
                                    ("Purple", Color.purple)
                                ], id: \.0) { name, color in
                                    DemoCard(
                                        title: name,
                                        style: .customBlur,
                                        colorTint: color,
                                        colorTintAlpha: colorTintAlpha,
                                        blurRadius: blurRadius,
                                        saturation: saturation,
                                        height: 120
                                    )
                                }
                            }
                        }
                    }
                    
                    // Glass Effect Section
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Glass Effect")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .padding(.horizontal, 4)
                        
                        DemoCard(
                            title: "Glass Regular",
                            style: .glass(.regular)
                        )
                    }
                }
                .padding()
            }
        }
    }
}

// MARK: - Demo Card

struct DemoCard: View {
    let title: String
    let style: VisualEffectView.VisualEffectStyle
    let colorTint: Color?
    let colorTintAlpha: CGFloat
    let blurRadius: CGFloat
    let saturation: CGFloat
    var height: CGFloat = 200
    
    init(
        title: String,
        style: VisualEffectView.VisualEffectStyle,
        colorTint: Color? = nil,
        colorTintAlpha: CGFloat = 0,
        blurRadius: CGFloat = 0,
        saturation: CGFloat = 1,
        height: CGFloat = 200
    ) {
        self.title = title
        self.style = style
        self.colorTint = colorTint
        self.colorTintAlpha = colorTintAlpha
        self.blurRadius = blurRadius
        self.saturation = saturation
        self.height = height
    }
    
    var body: some View {
        ZStack {
            Group {
                if style == .customBlur {
                    VisualEffect(
                        colorTint: colorTint,
                        colorTintAlpha: colorTintAlpha,
                        blurRadius: blurRadius,
                        saturation: saturation
                    )
                } else {
                    VisualEffect(style: style)
                }
            }
            .frame(height: height)
            .cornerRadius(20)
            .overlay {
                VStack(spacing: 8) {
                    Text(title)
                        .font(.headline)
                    if style == .customBlur {
                        Text("Blur: \(Int(blurRadius))")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                }
                .padding()
            }
        }
    }
}

// MARK: - Animated Background

struct AnimatedBackground: View {
    var body: some View {
        TimelineView(.animation) { timeline in
            let time = timeline.date.timeIntervalSinceReferenceDate
            
            ZStack {
                LinearGradient(
                    colors: [.blue, .purple, .pink, .orange],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                
                // Animated shapes
                ForEach(0..<3, id: \.self) { index in
                    Circle()
                        .fill(
                            LinearGradient(
                                colors: [.white.opacity(0.2), .clear],
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                        .frame(width: 200 + Double(index) * 100)
                        .offset(
                            x: cos(time / 5 + Double(index) * 2) * 100,
                            y: sin(time / 5 + Double(index) * 2) * 100
                        )
                }
            }
        }
    }
}

// MARK: - Preview

#Preview {
    ContentView()
}
