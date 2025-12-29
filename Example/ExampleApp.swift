//
//  ExampleApp.swift
//  Example
//
//  Created by Lasha Efremidze on 8/14/25.
//  Copyright © 2025 Lasha Efremidze. All rights reserved.
//

import SwiftUI

@main
struct ExampleApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                ContentView()
                    .tabItem {
                        Label("Modern", systemImage: "sparkles")
                    }
                
                LegacyContentView()
                    .tabItem {
                        Label("Legacy", systemImage: "clock.arrow.circlepath")
                    }
            }
        }
    }
}
