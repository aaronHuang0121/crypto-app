//
//  CryptoApp.swift
//  Crypto App
//
//  Created by Aaron on 2024/8/22.
//

import SwiftUI

@main
struct CryptoApp: App {
    @StateObject private var launchViewModel = LaunchViewModel()

    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [
            .foregroundColor: UIColor(.accent)
        ]
        
        UINavigationBar.appearance().titleTextAttributes = [
            .foregroundColor: UIColor(.accent)
        ]
    }
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                GeometryReader { geometry in
                    ContentView()
                        .environment(
                            \.device,
                             .init(
                                screenWidth: geometry.size.width,
                                screenHeight: geometry.size.height,
                                insets: geometry.safeAreaInsets
                             )
                        )
                }
                if launchViewModel.showLaunchView {
                    LaunchView()
                        .environmentObject(launchViewModel)
                        .transition(.move(edge: .leading))
                        .zIndex(2)
                }
            }
            .animation(.spring, value: launchViewModel.showLaunchView)
        }
    }
}
