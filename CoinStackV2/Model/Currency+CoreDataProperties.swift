//
//  Currency+CoreDataProperties.swift
//  CoinStackV2
//
//  Created by Michael Heide on 01.07.20.
//  Copyright © 2020 Michael Heide. All rights reserved.
//
//

import Foundation
import CoreData


extension Currency {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Currency> {
        return NSFetchRequest<Currency>(entityName: "Currency")
    }

    @NSManaged public var changePercent24Hr: Double
    @NSManaged public var id: String?
    @NSManaged public var imgUrl: String
    @NSManaged public var isFavorite: Bool
    @NSManaged public var marketCapUsd: Double
    @NSManaged public var maxSupply: Double
    @NSManaged public var name: String
    @NSManaged public var priceUsd: Double
    @NSManaged public var rank: Int16
    @NSManaged public var supply: Double
    @NSManaged public var symbol: String
    @NSManaged public var volumeUsd24Hr: Double
    @NSManaged public var vwap24Hr: Double
    @NSManaged public var invest: Invest?
    @NSManaged public var orders: NSSet?
}
