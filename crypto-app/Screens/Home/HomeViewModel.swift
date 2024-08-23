//
//  HomeViewModel.swift
//  crypto-app
//
//  Created by Aaron on 2024/8/22.
//

import Combine
import Foundation
import SwiftUI

final class HomeViewModel: ObservableObject {
    @Published var showPortolio: Bool = false
    @Published var allCoins: [Coin] = []
    @Published var portolioCoins: [Coin] = []
    
    var cancellables: AnyCancellable?
    
    init() {
        getCoins()
    }
    
    func onShowPortfolio() -> Void {
        showPortolio.toggle()
    }
    
    private func getCoins() {
        cancellables = NetworkManager.shared
            .getCoins(
                params: .init(
                    vsCurrency: "usd",
                    order: .marketCapDesc,
                    perPage: 250,
                    page: 1,
                    sparkline: true,
                    priceChangePercentage: "24h"
                )
            )
            .sink(receiveCompletion: {
                switch $0 {
                case .finished:
                    break
                case .failure(let error):
                    print("subscribe error: \(error.localizedDescription)")
                }
            }, receiveValue: { [weak self] coins in
                self?.allCoins = coins
                self?.cancellables?.cancel()
            })
    }
}
