//
//  Order.swift
//  CoinStackV2
//
//  Created by Michael Heide on 02.07.20.
//  Copyright © 2020 Michael Heide. All rights reserved.
//

import Foundation
import CoreData


extension Order {

    
    static func fetchRequest(_ predicate: NSPredicate) -> NSFetchRequest<Order>{
        let request = NSFetchRequest<Order>(entityName: "Order")
        request.sortDescriptors = [NSSortDescriptor(
            key: "date", ascending: false
            )]
        request.predicate = predicate
        return request
    }
    
    
}
