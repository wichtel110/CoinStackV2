//
//  Currency.swift
//  CoinStackV2
//
//  Created by Michael Heide on 25.06.20.
//  Copyright © 2020 Michael Heide. All rights reserved.
//

import CoreData
import Foundation

extension Currency{
    
    static func fetchRequest(_ predicate: NSPredicate) -> NSFetchRequest<Currency>{
        let request = NSFetchRequest<Currency>(entityName: "Currency")
        request.sortDescriptors = [NSSortDescriptor(
            key: "rank", ascending: true
            )]
        request.predicate = predicate
        return request
    }
    
    static func getById(_ id: String, context: NSManagedObjectContext) -> Currency?{
        let request = Currency.fetchRequest(NSPredicate(format: "id = %@", id))
        let currencies = (try? context.fetch(request)) ?? []
        
        if let currency = currencies.first {
            return currency
        }else{
            return nil
        }
    }
    
    static func createByAsset(_ asset: Asset, context: NSManagedObjectContext) {
        if getById(asset.id, context: context) == nil {
            let newCurrency = Currency(context: context)
            newCurrency.id = asset.id
            newCurrency.name = asset.name
            newCurrency.symbol = asset.symbol
            newCurrency.rank = Int16(asset.rank) ?? 0
            newCurrency.priceUsd = Double(asset.priceUsd) ?? 0
            newCurrency.marketCapUsd = Double(asset.marketCapUsd) ?? 0.0
            newCurrency.supply = Double(asset.supply) ?? 0.0
            newCurrency.volumeUsd24Hr = Double(asset.volumeUsd24Hr) ?? 0.0
            newCurrency.isFavorite = false
            
            newCurrency.imgUrl = "https://cryptoicons.org/api/icon/" + asset.symbol + "/200"
            
            if let changePercent24Hr = asset.changePercent24Hr{
                newCurrency.changePercent24Hr = Double(changePercent24Hr) ?? 0.0
            }else{
                newCurrency.changePercent24Hr = 0.0
            }
            if let maxSupply = asset.maxSupply{
                newCurrency.maxSupply = Double(maxSupply) ?? 0.0
            }else{
                newCurrency.maxSupply = 0.0
            }
            if let vwap24Hr = asset.vwap24Hr {
                newCurrency.vwap24Hr = Double(vwap24Hr) ?? 0
            }else{
                newCurrency.vwap24Hr = 0.0
            }
            print("\(newCurrency)")
            newCurrency.objectWillChange.send()
            try? context.save()
        }
        else{
            Currency.updateByAsset(asset, context: context)
        }
    }
    
    static func updateByAsset(_ asset: Asset, context: NSManagedObjectContext){
        if let currency = Currency.getById(asset.id, context: context){
            currency.id = asset.id
            currency.name = asset.name
            currency.symbol = asset.symbol
            currency.rank = Int16(asset.rank) ?? 0
            currency.priceUsd = Double(asset.priceUsd) ?? 0
            currency.marketCapUsd = Double(asset.marketCapUsd) ?? 0.0
            currency.supply = Double(asset.supply) ?? 0.0
            currency.volumeUsd24Hr = Double(asset.volumeUsd24Hr) ?? 0.0
            
            if let changePercent24Hr = asset.changePercent24Hr{
                currency.changePercent24Hr = Double(changePercent24Hr) ?? 0.0
            }else{
                currency.changePercent24Hr = 0.0
            }
            if let maxSupply = asset.maxSupply{
                currency.maxSupply = Double(maxSupply) ?? 0.0
            }else{
                currency.maxSupply = 0.0
            }
            if let vwap24Hr = asset.vwap24Hr {
                currency.vwap24Hr = Double(vwap24Hr) ?? 0
            }else{
                currency.vwap24Hr = 0.0
            }
            
            if let invest = currency.invest{
                invest.objectWillChange.send()
            }
            
            
            currency.objectWillChange.send()
            try? context.save()
        }
        
    }
    
    static func toggleFav(_ asset: Currency, context: NSManagedObjectContext) -> Currency?{
        if let id = asset.id{
            
            if let currency = Currency.getById(id, context: context){
                currency.isFavorite = !currency.isFavorite
                currency.objectWillChange.send()
                try? context.save()
                return currency
            }else{
                return nil
            }
            
        }else{
            return nil
        }
        
    }
    
}
