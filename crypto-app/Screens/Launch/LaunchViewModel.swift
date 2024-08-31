//
//  LaunchViewModel.swift
//  crypto-app
//
//  Created by Aaron on 2024/8/31.
//

import Combine
import Foundation

final class LaunchViewModel: ObservableObject {
    @Published var showLoadingText: Bool = false
    @Published var counter: Int = 0
    @Published var showLaunchView: Bool = true
    let loadingText: [String] = "Loading your portfolio...".map({ String($0) })
    @Published var loops: Int = 0
    var cancellables = Set<AnyCancellable>()

    init() {
        Timer
            .publish(every: 0.1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self else { return }
                if self.counter == self.loadingText.count - 1 {
                    self.counter = 0
                    self.loops += 1
                    if loops > 0 {
                        self.counter = -1
                        self.showLaunchView = false
                        self.cancellables.removeAll()
                    }
                } else {
                    self.counter += 1
                }
            }
            .store(in: &cancellables)
        
    }
}
