//
//  PortolioView.swift
//  crypto-app
//
//  Created by Aaron on 2024/8/27.
//

import SwiftUI

struct PortolioView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var homeViewModel: HomeViewModel
    @StateObject private var viewModel = PortolioViewModel()

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    SearchBar(searchKey: $homeViewModel.searchKey)
                    
                    CoinList()
                        .animation(.none, value: viewModel.selectedCoin)
                    
                    InputSection()
                }
            }
            .navigationTitle("Edit Portolio")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(
                        action: {
                            dismiss()
                        },
                        label: {
                            Image(systemName: "xmark")
                                .font(.headline)
                        }
                    )
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    TrailingToolbarItem()
                }
            }
            
        }
    }
}

extension PortolioView {
    @ViewBuilder
    private func CoinList() -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack {
                ForEach(homeViewModel.filterCoins) { coin in
                    CoinLogo(coin: coin, isSelected: viewModel.isSelectedCoin(coin: coin))
                        .frame(height: 105)
                        .gesture(
                            TapGesture()
                                .onEnded({
                                    viewModel.onSelectCoin(coin)
                                })
                        )
                }
            }
            .padding(.vertical, 4)
            .padding(.leading)
        }
    }
    
    @ViewBuilder
    private func InputSection() -> some View {
        if let selectedCoin = viewModel.selectedCoin {
            VStack(spacing: 20) {
                HStack {
                    Text("Current price of \(selectedCoin.symbol.uppercased())")
                    
                    Spacer()
                    
                    Text(selectedCoin.currentPrice.asCurrencyWith2Decimals())
                }
                
                Divider()
                
                HStack {
                    Text("Amount of your portolio:")
                    Spacer()
                    TextField("Ex: 1.4", text: $viewModel.quantityText)
                        .multilineTextAlignment(.trailing)
                        .keyboardType(.decimalPad)
                }
                
                Divider()
                
                HStack {
                    Text("Current value:")
                    
                    Spacer()
                    
                    Text(viewModel.currentValue.asCurrencyWith2Decimals())
                }
            }
            .padding()
            .font(.headline)
        }
    }
    
    @ViewBuilder
    private func TrailingToolbarItem() -> some View {
        HStack(spacing: 10) {
            Image(systemName: "checkmark")
                .opacity(viewModel.showCheckmark ? 1 : 0)
            
            Button(
                action: viewModel.onSave,
                label: {
                    Text("Save".uppercased())
                }
            )
            .opacity(viewModel.showSaveButton ? 1 : 0)
        }
        .onReceive(
            viewModel.$selectedCoin,
            perform: { coin in
                if coin == nil {
                    homeViewModel.searchKey = ""
                }
            }
        )
    }
}

#Preview {
    PortolioView()
        .environmentObject(HomeViewModel())
}
