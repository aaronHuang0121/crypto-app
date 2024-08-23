//
//  CircleButtonAnimation.swift
//  crypto-app
//
//  Created by Aaron on 2024/8/22.
//

import SwiftUI

struct CircleButtonAnimation: View {
    @Binding var animate: Bool

    var body: some View {
        Circle()
            .stroke(lineWidth: 5)
            .scale(animate ? 1 : 0)
            .opacity(animate ? 0 : 1)
            .animation(animate ? .easeOut(duration: 1) : .none, value: animate)
    }
}

private struct PreviewWrapper: View {
    @State private var animate: Bool = false
    var body: some View {
        CircleButtonAnimation(animate: $animate)
            .foregroundStyle(.red)
            .frame(width: 100, height: 100)
        
        Button(action: { animate.toggle() }, label: {
            Text("Toggle animate")
        })
    }
}

#Preview {
    PreviewWrapper()
}
