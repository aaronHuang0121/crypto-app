//
//  Statistic.swift
//  crypto-app
//
//  Created by Aaron on 2024/8/27.
//

import Foundation

struct Statistic: Identifiable {
    let title: String
    let value: String
    let percentage: Double?
    
    var id: String { title }
}

extension Statistic {
    static let mock = Statistic(title: "Market Cap", value: "$12.5Bn", percentage: 25.34)
    
    static let mock2 = Statistic(title: "Total Volumn", value: "$1,23Tr", percentage: nil)
    
    static let mock3 = Statistic(title: "Portfolio Value", value: "$50.4k", percentage: -12.34)
}
