//
//  UIApplication+EndEditing.swift
//  crypto-app
//
//  Created by Aaron on 2024/8/26.
//

import Foundation
import UIKit

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
