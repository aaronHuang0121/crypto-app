//
//  HomeView.swift
//  crypto-app
//
//  Created by Aaron on 2024/8/22.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()

    var body: some View {
        VStack {
            Header()

            Spacer()
        }
        .navigationBarBackButtonHidden()
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
            
            Text("Portfolio")
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
}

#Preview {
    NavigationView {
        HomeView()
    }
}
