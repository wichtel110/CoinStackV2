//
//  Asset.swift
//  CoinStackV2
//
//  Created by Michael Heide on 02.06.20.
//  Copyright © 2020 Michael Heide. All rights reserved.
//

import Foundation


    
struct Root: Codable {
    var data: [Asset]
}

struct Asset: Codable, Identifiable, Hashable {
    let id: String
    let rank: String
    let symbol: String
    let name: String
    var supply: String
    var maxSupply: String?
    var marketCapUsd: String
    var volumeUsd24Hr: String
    var priceUsd: String
    var changePercent24Hr: String?
    var vwap24Hr: String?
    
    //Aditional Attributes
    var isWatched: Bool = false
    var isSwipped: Bool = false

    enum CodingKeys: String, CodingKey {
        case id, rank, symbol, name, supply, maxSupply, marketCapUsd, volumeUsd24Hr, priceUsd, changePercent24Hr, vwap24Hr
    }
}
