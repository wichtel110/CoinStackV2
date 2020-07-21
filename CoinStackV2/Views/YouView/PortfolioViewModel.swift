//
//  PortfolioViewModel.swift
//  CoinStackV2
//
//  Created by Michael Heide on 08.07.20.
//  Copyright © 2020 Michael Heide. All rights reserved.
//

import SwiftUI
import Combine
import CoreData


class PortfolioViewModel: ObservableObject {
    
    @Published private var portfolio: Portfolio
    
    private static let untitled = "MyPortfolioValue"
    
    private var autosaveCancellable: AnyCancellable?
    
    private var invests: [Invest]?
    
    private var context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext){
        self.context = context
        self.portfolio = Portfolio(json: UserDefaults.standard.data(forKey: PortfolioViewModel.untitled)) ?? Portfolio()
        self.autosaveCancellable = $portfolio.sink { portfolio in
            UserDefaults.standard.set(portfolio.json, forKey: PortfolioViewModel.untitled)
        }
        fetchAllInvests()
    }
    
    func fetchAllInvests(){
        let request = Invest.fetchRequest(NSPredicate.all)
        self.invests = (try? context.fetch(request))
        var portfolioValue:Double = 0.0
        var portfolioGain24h: Double = 0.0
        var portfolioInvest: Double = 0.0
        if invests != nil{
            self.invests?.forEach({ invest in
                portfolioValue += invest.cryptoAmount * invest.currency.priceUsd
                portfolioGain24h += invest.currency.changePercent24Hr
                portfolioInvest += invest.usdAmount
            })
            portfolio.invest = portfolioInvest
            portfolio.value = portfolioValue
            portfolio.gain = (portfolioGain24h / Double(invests!.count))
        }
    }
    
    func getValue() -> Double{
        return portfolio.value
    }
    
    func getGain() -> Double{
        return portfolio.gain
    }
    
    func getInvest() -> Double {
        return portfolio.invest
    }
    
    func getInvestGain() -> Double{
        return ((getValue()/getInvest()) - 1) * 100
    }
    
    func getInvestGainValue() -> Double {
        return getValue() - portfolio.invest
    }
    
    func getGainValue() -> Double {
        return portfolio.value * (portfolio.gain / 100)
    }
    
}

struct Portfolio: Codable {
    var value: Double = 0
    var invest: Double = 0
    var gain: Double = 0
    
    
    var json: Data? {
        return try? JSONEncoder().encode(self)
    }
    
    init?(json: Data?) {
        if json != nil, let newPortfolio = try? JSONDecoder().decode(Portfolio.self, from: json!) {
            self = newPortfolio
        } else {
            return nil
        }
    }

    init(){
        
    }
}
