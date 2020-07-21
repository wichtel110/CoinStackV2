//
//  SellDetailViewModel.swift
//  CoinStackV2
//
//  Created by Michael Heide on 21.07.20.
//  Copyright © 2020 Michael Heide. All rights reserved.
//

import Foundation
import CoreData

class SellDetailViewModel: ObservableObject{
    
    private var context: NSManagedObjectContext
    
    @Published var invests: [Invest]?

    
    init(context: NSManagedObjectContext){
        self.context = context
        
        fetchAllInvests()
    }
    
    
    
    func fetchAllInvests(){
         let request = Invest.fetchRequest(NSPredicate.all)
         self.invests = (try? context.fetch(request))
     }

    func sellInvest(coinAmount: Double, invest: Invest?, date: Date, usdAmount: Double){
        print("\(coinAmount)")
        
        if let linkedInvest = invest{
            let order = Order(context: self.context)
            order.coinAmount = coinAmount * -1
            order.currency = linkedInvest.currency
            order.date = date
            order.id = UUID().uuidString
            order.usdAmount = usdAmount * -1
            order.price = linkedInvest.currency.priceUsd
            order.objectWillChange.send()
            order.orderType = "SELL"
            order.symbol = linkedInvest.currency.symbol
            try? context.save()
            
            Invest.updateInvest(order: order, context: context)

            }

    }
}
