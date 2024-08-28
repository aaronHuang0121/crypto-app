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
            
            SearchBar(searchKey: $viewModel.searchKey)
            
            ColumnsHeader()

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
        .navigationDestination(
            for: Coin.self,
            destination: { coin in
                DetailView(coin: coin)
            }
        )
        .animation(.spring, value: viewModel.showPortolio)
        .sheet(isPresented: $viewModel.showPortolioView) {
            PortolioView()
                .environmentObject(viewModel)
        }
    }
}

extension HomeView {
    @ViewBuilder
    private func Header() -> some View {
        HStack {
            CircleButton(
                systemName: viewModel.showPortolio ? "plus" : "info",
                action: {
                    if viewModel.showPortolio {
                        viewModel.showPortolioView.toggle()
                    }
                }
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
    private func ColumnsHeader() -> some View {
        HStack {
            ColumnHeader(
                title: "Coin",
                showSortOption: viewModel.sortOption.isRank,
                reversed: viewModel.sortOption.reversed,
                action: { viewModel.onSort(.rank()) }
            )
            Spacer()

            if viewModel.showPortolio {
                ColumnHeader(
                    title: "Holdings",
                    showSortOption: viewModel.sortOption.isHoldings,
                    reversed: viewModel.sortOption.reversed,
                    action: { viewModel.onSort(.holdings()) }
                )
            }

            ColumnHeader(
                title: "Price",
                showSortOption: viewModel.sortOption.isPrice,
                reversed: viewModel.sortOption.reversed,
                action: { viewModel.onSort(.price()) }
            )
            .frame(width: device.safeAreaWidth / 3.5, alignment: .trailing)

            Button(
                action: viewModel.reload,
                label: {
                    Image(systemName: "goforward")
                        .rotationEffect(.degrees(viewModel.isLoading ? 360 : 0))
                }
            )

        }
        .foregroundStyle(.secondaryText)
        .padding(.horizontal)
        .font(.caption)
        .animation(.default, value: viewModel.sortOption)
    }
    
    @ViewBuilder
    private func CoinList(_ coins: [Coin]) -> some View {
        ScrollViewReader { proxy in
            List(coins) { coin in
                NavigationLink(
                    value: coin,
                    label: {
                        CoinCell(coin: coin, showHoldingColumns: viewModel.showPortolio)
                            .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 0))
                            .id(coin.id)
                    }
                )
            }
            .listStyle(.plain)
            .onReceive(
                viewModel.$isLoading,
                perform: { isLoading in
                    if !isLoading {
                        withAnimation(.linear) {
                            proxy.scrollTo(coins.first?.id)
                        }
                    }
                }
            )
        }
    }
}

#Preview {
    NavigationView {
        HomeView()
    }
}
