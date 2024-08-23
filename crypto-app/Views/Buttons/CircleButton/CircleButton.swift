//
//  CircleButton.swift
//  crypto-app
//
//  Created by Aaron on 2024/8/22.
//

import SwiftUI

struct CircleButton: View {
    let systemName: String
    let action: () -> Void

    var body: some View {
        Image(systemName: systemName)
            .font(.headline)
            .foregroundStyle(.accent)
            .scaledToFit()
            .frame(width: 50, height: 50)
            .background {
                Circle()
                    .fill(Color.background)
            }
            .shadow(color: Color.accent.opacity(0.25), radius: 10)
            .padding()
            .gesture(
                TapGesture()
                    .onEnded(action)
            )
    }
}

#Preview("Light", traits: .sizeThatFitsLayout) {
    CircleButton(
        systemName: "heart.fill",
        action: { print("tap") }
    )
}

#Preview("Dark", traits: .sizeThatFitsLayout) {
    CircleButton(
        systemName: "heart.fill",
        action: {}
    )
    .preferredColorScheme(.dark)
}
