//
//  HomeViewModel.swift
//  crypto-app
//
//  Created by Aaron on 2024/8/22.
//

import Foundation

final class HomeViewModel: ObservableObject {
    @Published var showPortolio: Bool = false
    
    func onShowPortfolio() -> Void {
        showPortolio.toggle()
    }
}
