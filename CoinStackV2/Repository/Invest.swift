//
//  Invest.swift
//  CoinStackV2
//
//  Created by Michael Heide on 03.07.20.
//  Copyright © 2020 Michael Heide. All rights reserved.
//

import Foundation
import CoreData

extension Invest{

    static func fetchRequest(_ predicate: NSPredicate) -> NSFetchRequest<Invest> {
        let request = NSFetchRequest<Invest>(entityName: "Invest")
        request.sortDescriptors = [NSSortDescriptor(
            key: "usdAmount", ascending: true)]
        
        request.predicate = predicate
        return request
    }
    
    static func refreshInvest(context: NSManagedObjectContext){
        let request = Invest.fetchRequest(NSPredicate.all)
        let invests = (try? context.fetch(request)) ?? []
        
        invests.forEach { invest in
            invest.objectWillChange.send()
        }
        
    }
    
    static func getBySymbol(symbol: String, context: NSManagedObjectContext) -> Invest?{
            let request = Invest.fetchRequest(NSPredicate(format: "symbol = %@", symbol))
            let invests = (try? context.fetch(request)) ?? []
            
            if let invest = invests.first {
                return invest
            }else{
                return nil
            }
        }

    static func updateInvest(order: Order, context: NSManagedObjectContext){
        var investable: Invest?
        investable = Invest.getBySymbol(symbol: order.symbol, context: context)
        if let invest = investable{
            // update
            invest.usdAmount += order.usdAmount
            invest.cryptoAmount += order.coinAmount
        }else {
            // create
            print("creat new invest")
            createInvest(order: order, context: context)
        }
    }
    
    static func createInvest(order: Order, context: NSManagedObjectContext){
        if getBySymbol(symbol: order.symbol, context: context) == nil {
            let invest = Invest(context: context)
            invest.usdAmount = order.usdAmount
            invest.cryptoAmount = order.coinAmount
            invest.currency = order.currency
            invest.gain = 0.0
            invest.startInvest = Date()
            invest.name = order.currency.name
            invest.symbol = order.currency.symbol
            
            invest.objectWillChange.send()
            try? context.save()
        }
    }
    
}

