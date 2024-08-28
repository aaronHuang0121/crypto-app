//
//  DetailView.swift
//  crypto-app
//
//  Created by Aaron on 2024/8/28.
//

import SwiftUI

struct DetailView: View {
    let coin: Coin
    
    init(coin: Coin) {
        self.coin = coin
        print("Initialize \(coin.id) view")
    }
    var body: some View {
        Text("Hello, World!")
    }
}

#Preview {
    DetailView(coin: .mock)
}
