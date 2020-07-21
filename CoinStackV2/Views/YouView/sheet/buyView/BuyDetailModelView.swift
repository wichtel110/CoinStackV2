//
//  BuyDetailModelView.swift
//  CoinStackV2
//
//  Created by Michael Heide on 02.07.20.
//  Copyright © 2020 Michael Heide. All rights reserved.
//

import Foundation
import CoreData

class BuyDetailModelView: ObservableObject{
    
    private var context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext){
        self.context = context
    }

    func createNewOrder(coinAmount: Double, currency: Currency?, date: Date, usdAmount: Double){
        print("\(coinAmount)")
        
        if let linkedCurrency = currency{
            let order = Order(context: self.context)
            order.coinAmount = coinAmount
            order.currency = linkedCurrency
            order.date = date
            order.id = UUID().uuidString
            order.usdAmount = usdAmount
            order.price = linkedCurrency.priceUsd
            order.objectWillChange.send()
            order.orderType = "BUY"
            order.symbol = linkedCurrency.symbol
            try? context.save()
            Invest.updateInvest(order: order, context: context)

            }

    }
}

