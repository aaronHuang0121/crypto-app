//
//  LaunchView.swift
//  crypto-app
//
//  Created by Aaron on 2024/8/31.
//

import SwiftUI

struct LaunchView: View {
    @EnvironmentObject private var viewModel: LaunchViewModel
    
    var body: some View {
        ZStack {
            Color.launchBackground
                .ignoresSafeArea()
            
            Image("logo-transparent")
                .resizable()
                .frame(width: 100, height: 100)
            
            if viewModel.showLoadingText {
                HStack(spacing: 0) {
                    ForEach(
                        Array(viewModel.loadingText.enumerated()),
                        id: \.offset
                    ) { index, value in
                        Text(value)
                            .offset(y: index == viewModel.counter ? -5 : 0)
                    }
                }
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundStyle(.launchAccent)
                .offset(y: 70)
                .transition(.scale.animation(.easeIn))
                .animation(.spring, value: viewModel.counter)
            }
        }
        .onAppear {
            viewModel.showLoadingText.toggle()
        }
    }
}

#Preview {
    LaunchView()
        .environmentObject(LaunchViewModel())
}
