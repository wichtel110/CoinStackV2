//
//  Order+CoreDataProperties.swift
//  CoinStackV2
//
//  Created by Michael Heide on 02.07.20.
//  Copyright © 2020 Michael Heide. All rights reserved.
//
//

import Foundation
import CoreData


extension Order {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Order> {
        return NSFetchRequest<Order>(entityName: "Order")
    }

    @NSManaged public var id: String?
    @NSManaged public var date: Date?
    @NSManaged public var usdAmount: Double
    @NSManaged public var coinAmount: Double
    @NSManaged public var price: Double
    @NSManaged public var currency: Currency
    @NSManaged public var orderType: String
    @NSManaged public var symbol: String


}
