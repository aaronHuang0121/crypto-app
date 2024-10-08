//
//  PortolioViewModel.swift
//  crypto-app
//
//  Created by Aaron on 2024/8/27.
//

import Foundation
import SwiftUI

class PortolioViewModel: ObservableObject {
    @Published var selectedCoin: Coin? = nil
    @Published var quantityText: String = ""
    @Published var showCheckmark: Bool = false
    
    var currentValue: Double {
        guard let selectedCoin, let quantity = Double(quantityText) else {
            return 0
        }
        
        return selectedCoin.currentPrice * quantity
    }
    
    var showSaveButton: Bool {
        guard let selectedCoin else {
            return false
        }
        
        return selectedCoin.currentHoldings != Double(quantityText)
    }
}

extension PortolioViewModel {
    func isSelectedCoin(coin: Coin) -> Bool {
        guard let selectedCoin else {
            return false
        }
        return coin.id == selectedCoin.id
    }
    
    func onSelectCoin(_ coin: Coin) -> Void {
        withAnimation(.easeIn) {
            self.selectedCoin = coin
        }
    }
    
    func onSave() -> Void {
        guard let selectedCoin, let amount = Double(quantityText) else {
            return
        }
        
        PortolioDataService.shared.updatePortolio(selectedCoin, amount: amount)
        
        withAnimation(.easeIn) {
            showCheckmark = true
            removeSelectedCoin()
        }
        
        UIApplication.shared.endEditing()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            withAnimation(.easeOut) {
                self.showCheckmark = false
            }
        }
    }
    
    private func removeSelectedCoin() -> Void {
        selectedCoin = nil
    }

    func updatedSelectedCoin(_ coin: Coin?, portolios: [Coin]) {
        guard let coin else {
            return
        }
        
        if let defaultCoin = portolios.first(where: { $0.id == coin.id }), let amount = defaultCoin.currentHoldings {
            quantityText = "\(amount)"
        } else {
            quantityText = ""
        }
    }
}
