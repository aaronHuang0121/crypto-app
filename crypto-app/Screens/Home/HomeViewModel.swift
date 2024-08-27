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
    @Published var filterCoins: [Coin] = []
    @Published var portolioCoins: [Coin] = []
    @Published var statistics: [Statistic] = [.mock, .mock2, .mock3]
    @Published var searchKey: String = ""

    var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
    }
    
    func onShowPortfolio() -> Void {
        showPortolio.toggle()
    }
    
    private func addSubscribers() {
        getCoins()

        $searchKey
            .combineLatest($allCoins)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filterCoins)
            .sink(
                receiveCompletion: {
                    switch $0 {
                    case .finished:
                        print("finished")
                    case .failure(let error):
                        print("subscribe error: \(error.localizedDescription)")
                    }
                },
                receiveValue: { [weak self] coins in
                    self?.filterCoins = coins
                }
            )
            .store(in: &cancellables)
    }
    
    private func getCoins() {
        NetworkManager.shared
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
            .sink(
                receiveCompletion: {
                    switch $0 {
                    case .finished:
                        break
                    case .failure(let error):
                        print("subscribe error: \(error.localizedDescription)")
                    }
                },
                receiveValue: { [weak self] coins in
                    self?.allCoins = coins
                }
            )
            .store(in: &cancellables)
    }
    
    private func filterCoins(key: String, coins: [Coin]) -> [Coin] {
        guard !key.isEmpty else {
            return coins
        }
        
        let key = key.lowercased()
        
        return coins
            .filter({ coin in
                return coin.name.lowercased().contains(key) || coin.symbol.lowercased().contains(key) || coin.id.contains(key)
            })
    }
}
