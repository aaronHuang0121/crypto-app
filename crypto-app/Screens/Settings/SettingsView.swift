//
//  SettingsView.swift
//  crypto-app
//
//  Created by Aaron on 2024/8/31.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationView {
            List {
                AboutApp()
                    .listRowBackground(Color.background.opacity(0.5))
                
                CoinGecko()
                    .listRowBackground(Color.background.opacity(0.5))
                
                Developer()
                    .listRowBackground(Color.background.opacity(0.5))
            }
            .font(.headline)
            .listStyle(GroupedListStyle())
            .navigationTitle("Settings")
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
            }
        }
    }
}

extension SettingsView {
    @ViewBuilder
    private func AboutApp() -> some View {
        Section("About App") {
            VStack(alignment: .leading) {
                Image("logo")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                Text("This app was learned and made from a @SwiftfulThinking course on YouTube. It uses MVVM Architecture, Combine, and CoreData!")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundStyle(.accent)
            }
            
            if let githubLink = URL(string: "https://github.com/aaronHuang0121/crypto-app") {
                Link("View on Github", destination: githubLink)
                    .foregroundStyle(.blue)
            }
        }
    }
    
    @ViewBuilder
    private func CoinGecko() -> some View {
        Section("CoinGecko") {
            VStack(alignment: .leading) {
                Image("coingecko")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                Text("The cryptocurrency data that is used in this app comes from a free API from CoinGecko! Prices may be slightly delayed.")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundStyle(.accent)
            }
            .padding(.vertical)
            
            if let coinGeckoLink = URL(string: "https://www.coingecko.com") {
                Link("Coin Gecko", destination: coinGeckoLink)
                    .foregroundStyle(.blue)
            }
        }
    }
    
    @ViewBuilder
    private func Developer() -> some View {
        Section(header: Text("Developer")) {
            VStack(alignment: .leading) {
                Image("github")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                Text("This app was developed by Aaron Huang. It uses SwiftUI and is written 100% in Swift. The project benefits from multi-threading, publishers/subscribers, and data persistance.")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundStyle(.accent)
            }
            .padding(.vertical)
            
            if let githubLink = URL(string: "https://github.com/aaronHuang0121") {
                Link("Personal Github", destination: githubLink)
                    .foregroundStyle(.blue)
            }
        }
    }
}

#Preview {
    SettingsView()
}
