//
//  HomeView.swift
//  crypto-app
//
//  Created by Aaron on 2024/8/22.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    @Environment(\.device) private var device

    var body: some View {
        VStack {
            Header()
            
            StatisticsRow(
                statistics: viewModel.statistics,
                showPortolio: viewModel.showPortolio
            )
            
            SearchBar(searchKey: $viewModel.searchKey)
            
            ColumnHeader()

            Group {
                if viewModel.showPortolio {
                    CoinList(viewModel.portolioCoins)
                        .transition(.move(edge: .trailing))
                } else {
                    CoinList(viewModel.filterCoins)
                        .transition(.move(edge: .leading))
                }
            }
            
            Spacer()
        }
        .navigationBarBackButtonHidden()
        .animation(.spring, value: viewModel.showPortolio)
    }
}

extension HomeView {
    @ViewBuilder
    private func Header() -> some View {
        HStack {
            CircleButton(
                systemName: viewModel.showPortolio ? "plus" : "info",
                action: {}
            )
            .background {
                CircleButtonAnimation(animate: $viewModel.showPortolio)
            }
            .animation(.none, value: viewModel.showPortolio)
            
            Spacer()
            
            Text(viewModel.showPortolio ? "Portfolio" : "Live Prices")
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundStyle(.accent)
            
            Spacer()
            
            CircleButton(
                systemName: "chevron.right",
                action: viewModel.onShowPortfolio
            )
            .rotationEffect(
                .degrees(viewModel.showPortolio ? 180 : 0)
            )
            .animation(.spring, value: viewModel.showPortolio)
        }
        .padding(.horizontal)
    }
    
    @ViewBuilder
    private func ColumnHeader() -> some View {
        HStack {
            Text("Coin")
            Spacer()
            if viewModel.showPortolio {
                Text("Holdings")
            }
            Text("Price")
                .frame(width: device.safeAreaWidth / 3.5, alignment: .trailing)
        }
        .foregroundStyle(.secondaryText)
        .padding(.horizontal)
    }
    
    @ViewBuilder
    private func CoinList(_ coins: [Coin]) -> some View {
        List(coins) { coin in
            CoinCell(coin: coin, showHoldingColumns: viewModel.showPortolio)
                .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 0))
        }
        .listStyle(.plain)
    }
}

#Preview {
    NavigationView {
        HomeView()
    }
}
