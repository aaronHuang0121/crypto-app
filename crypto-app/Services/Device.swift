//
//  Device.swift
//  crypto-app
//
//  Created by Aaron on 2024/8/23.
//

import Foundation
import SwiftUI

struct Device: Equatable {
    let screenWidth: CGFloat
    let screenHeight: CGFloat
    let insets: EdgeInsets

    init(
        screenWidth: CGFloat,
        screenHeight: CGFloat,
        insets: EdgeInsets
    ) {
        self.screenWidth = screenWidth
        self.screenHeight = screenHeight
        self.insets = insets
    }
    
    var safeAreaWidth: CGFloat {
        screenWidth - insets.leading - insets.trailing
    }
    
    var safeAreaHeight: CGFloat {
        screenHeight - insets.top - insets.bottom
    }
}

extension Device {
    init() {
        if let screen = UIScreen.current {
            self.screenWidth = screen.bounds.width
            self.screenHeight = screen.bounds.height
        } else {
            screenWidth = 0
            screenHeight = 0
        }
        
        if let window = UIWindow.current {
            insets = EdgeInsets(uiInsets: window.safeAreaInsets)
        } else {
            insets = .init()
        }
    }
}

extension EdgeInsets {
    init(uiInsets: UIEdgeInsets) {
        self.init(
            top: uiInsets.top,
            leading: uiInsets.left,
            bottom: uiInsets.bottom,
            trailing: uiInsets.right
        )
    }
}

extension UIWindow {
    static var current: UIWindow? {
        for scene in UIApplication.shared.connectedScenes {
            guard let windowScene = scene as? UIWindowScene else { continue }
            
            guard let window = windowScene.windows.first(where: { window in
                window.isKeyWindow
            }) else {
                continue
            }
            
            return window
        }
        
        return nil
    }
}

extension UIScreen {
    static var current: UIScreen? {
        UIWindow.current?.screen
    }
}

struct DeviceConfig: EnvironmentKey {
    static var defaultValue: Device = .init()
}

extension EnvironmentValues {
    var device: Device {
        get { self[DeviceConfig.self]  }
        set { self[DeviceConfig.self] = newValue }
    }
}
