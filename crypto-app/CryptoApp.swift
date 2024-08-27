//
//  CryptoApp.swift
//  Crypto App
//
//  Created by Aaron on 2024/8/22.
//

import SwiftUI

@main
struct CryptoApp: App {
    
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
        }
    }
}
