//
//  RemoteImage.swift
//  crypto-app
//
//  Created by Aaron on 2024/8/23.
//

import Combine
import SwiftUI

struct RemoteImage<Placeholder: View>: View {
    @State private var phase: AsyncImagePhase
    let url: URL?
    let placeholder: () -> Placeholder

    @State private var cancellables: AnyCancellable?

    init(
        url urlString: String,
        placeholder: @escaping () -> Placeholder = {
            Image(systemName: "photo.circle.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 50)
                .foregroundStyle(.accent)
        }
    ) {
        self.url = URL(string: urlString)
        if let url, let uiImage = NetworkManager.shared.getImageFromCache(url) {
            self._phase = .init(
                initialValue: .success(
                    Image(uiImage: uiImage)
                )
            )
        } else {
            self._phase = .init(initialValue: .empty)
        }
        self.placeholder = placeholder
    }
    
    var body: some View {
        Group {
            switch phase {
            case .empty:
                placeholder()
                    .onAppear(perform: fetchImage)
            case .success(let image):
                image
                    .resizable()
            case .failure:
                placeholder()
            @unknown default:
                Text("There should not show.")
            }
        }
    }
}

extension RemoteImage {
    private func fetchImage() {
        guard let url else { return }
        cancellables = NetworkManager.shared
            .downloadImage(url)
            .sink(
                receiveCompletion: {
                    switch $0 {
                    case .finished:
                        break
                    case .failure(let error):
                        print("Download image error: \(error.localizedDescription)")
                    }
                }, receiveValue: { image in
                    self.phase = .success(Image(uiImage: image))
                    self.cancellables?.cancel()
                }
            )
    }
}

#Preview {
    RemoteImage(url: "")
}
