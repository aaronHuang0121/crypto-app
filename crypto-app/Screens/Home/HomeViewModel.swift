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
    @Published var showPortolioView: Bool = false
    @Published var allCoins: [Coin] = []
    @Published var filterCoins: [Coin] = []
    @Published var portolioCoins: [Coin] = []
    @Published var statistics: [Statistic] = [.mock, .mock2, .mock3]
    @Published var searchKey: String = ""
    @Published var isLoading: Bool = false
    @Published var sortOption: SortOption = .rank(false)

    var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
    }
    
    func onShowPortfolio() -> Void {
        showPortolio.toggle()
    }

    func reload() -> Void {
        withAnimation(.linear(duration: 2)) {
            getCoins()
        }
    }

    func onSort(_ option: SortOption) -> Void {
        if option.isHoldings {
            if case .holdings(let reversed) = sortOption {
                self.sortOption = .holdings(!reversed)
            } else {
                self.sortOption = .holdings(false)
            }
        } else if option.isRank {
            if case .rank(let reversed) = sortOption {
                self.sortOption = .rank(!reversed)
            } else {
                self.sortOption = .rank(false)
            }
        } else {
            if case .price(let reversed) = sortOption {
                self.sortOption = .price(!reversed)
            } else {
                self.sortOption = .price(false)
            }
        }
    }
}

extension HomeViewModel {
    private func addSubscribers() {
        getCoins()

        $searchKey
            .combineLatest($allCoins, $sortOption)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filterAndSortCoins)
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
                    self?.filterCoins = coins
                    self?.isLoading = false
                }
            )
            .store(in: &cancellables)
        
        $allCoins
            .combineLatest(PortolioDataService.shared.$saveEntities, $sortOption)
            .map(sortPortolios)
            .sink(
                receiveCompletion: {
                    switch $0 {
                    case .finished:
                        break
                    case .failure(let error):
                        print("Portolios subscribe error: \(error.localizedDescription)")
                    }
                },
                receiveValue: { [weak self] coins in
                    self?.portolioCoins = coins
                }
            )
            .store(in: &cancellables)
    }
    
    private func getCoins() {
        self.isLoading = true
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
    
    private func filterAndSortCoins(key: String, coins: [Coin], sort: SortOption) -> [Coin] {
        let key = key.lowercased()
        
        var filtered = coins
            .filter({ coin in
                return coin.name.lowercased().contains(key) || coin.symbol.lowercased().contains(key) || coin.id.contains(key) || key.isEmpty
            })
        
        sortCoins(sort: sort, coins: &filtered)
        return filtered
    }

    private func sortPortolios(coins: [Coin], entities: [PortolioEntity], option: SortOption) -> [Coin] {
        var portolios = entities
            .compactMap({ portolio -> Coin? in
                guard var coin = coins.first(where: { $0.id == portolio.coinId }) else {
                    return nil
                }
                return coin.updateHoldings(portolio.amount)
            })
        
        sortCoins(sort: option, coins: &portolios)
        
        return portolios
    }
    
    private func sortCoins(sort: SortOption, coins: inout [Coin]) {
        switch sort {
        case .rank(let reverse), .holdings(let reverse):
            if reverse {
                coins.sort(by: { $0.rank > $1.rank })
            } else {
                coins.sort(by: { $0.rank < $1.rank })
            }
        case .price(let reverse):
            if reverse {
                coins.sort(by: { $0.currentPrice < $1.currentPrice })
            } else {
                coins.sort(by: { $0.currentPrice > $1.currentPrice })
            }
        }
    }
}

extension HomeViewModel {
    enum SortOption: Equatable {
        case rank(_ reverse: Bool = false)
        case holdings(_ reverse: Bool = false)
        case price(_ reverse: Bool = false)
        
        var isRank: Bool {
            switch self {
            case .rank:
                return true
            default:
                return false
            }
        }
        
        var isHoldings: Bool {
            switch self {
            case .holdings:
                return true
            default:
                return false
            }
        }
        
        var isPrice: Bool {
            switch self {
            case .price:
                return true
            default:
                return false
            }
        }
        
        var reversed: Bool {
            switch self {
            case .holdings(let reversed), .price(let reversed), .rank(let reversed):
                return reversed
            }
        }
    }
}
