//
//  HomeViewModel.swift
//  crypto-app
//
//  Created by Aaron on 2024/8/22.
//

import Foundation
import SwiftUI

final class HomeViewModel: ObservableObject {
    @Published var showPortolio: Bool = false
    @Published var allCoins: [Coin] = [.mock]
    @Published var portolioCoins: [Coin] = [.mock]
    
    func onShowPortfolio() -> Void {
        showPortolio.toggle()
    }
}
