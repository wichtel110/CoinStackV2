//
//  Invest+CoreDataProperties.swift
//  CoinStackV2
//
//  Created by Michael Heide on 03.07.20.
//  Copyright © 2020 Michael Heide. All rights reserved.
//
//

import Foundation
import CoreData


extension Invest {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Invest> {
        return NSFetchRequest<Invest>(entityName: "Invest")
    }

    @NSManaged public var id: String?
    @NSManaged public var symbol: String
    @NSManaged public var usdAmount: Double
    @NSManaged public var cryptoAmount: Double
    @NSManaged public var gain: Double
    @NSManaged public var startInvest: Date?
    @NSManaged public var name: String
    @NSManaged public var currency: Currency

}
