//
//  SellView.swift
//  CoinStackV2
//
//  Created by Michael Heide on 21.07.20.
//  Copyright © 2020 Michael Heide. All rights reserved.
//

import SwiftUI
import CoreData
import PartialSheet


struct SellDetailView: View {
    @ObservedObject var modelView: SellDetailViewModel
    @EnvironmentObject var partialSheetManager : PartialSheetManager
    
    @FetchRequest var assets: FetchedResults<Invest>
    
    @Binding var longer: Bool
    @Binding var mainViewActive: Bool
    
    
    init(context: NSManagedObjectContext, longer: Binding<Bool> ,mainViewActive: Binding<Bool>){
        UITableView.appearance().backgroundColor = .clear
        let request = Invest.fetchRequest(.all)
        _assets = FetchRequest(fetchRequest: request)
        self.modelView = SellDetailViewModel(context: context)
        _longer = longer
        _mainViewActive = mainViewActive
    }
    
    @State private var selectedStateString: String = ""
    @State private var selectedStateObject: Invest?
    
    @State private var textUsd: String = "USD amount"
    @State private var usdValue = 0.0
    @State private var cryptoAmount = 0.0

    @State private var date: Date = Date()
    
    private let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimum = 0
        formatter.maximum = 100000
        formatter.isPartialStringValidationEnabled = true
        formatter.isLenient = true
        return formatter
    }()
    
    var body: some View {
        VStack{
            Form{
                DatePicker(selection: $date, label: { Text("Date") })
                Picker(selection: $selectedStateString, label: Text("Currency")) {
                    ForEach(self.assets, id: \.self){ data in
                        Text("\(data.symbol)").tag(data.symbol)
                    }
                }
                .onReceive([self.selectedStateString].publisher.first()) { (value) in
                    self.selectedStateObject = self.assets.first(where: {
                        $0.symbol == value
                    })
                }
            if self.selectedStateObject != nil{
                Text("\(self.selectedStateObject!.name) currrent value: \((self.selectedStateObject?.currency.priceUsd.currencyUS)!)")
                Text("Current amount \((self.selectedStateObject?.cryptoAmount)!)")
                Text("Current portfolio Value \((self.selectedStateObject?.cryptoAmount)! * (self.selectedStateObject?.currency.priceUsd)!)")

                Section{
                    Text("Sell amount").bold()
                    TextField(textUsd, value: $cryptoAmount, formatter: self.numberFormatter)
                }
                
                
            }
            if self.selectedStateObject != nil && cryptoAmount > 0 && cryptoAmount < (self.selectedStateObject?.cryptoAmount)!{
                Button(action:{
                    self.modelView.sellInvest(coinAmount: self.cryptoAmount, invest: self.selectedStateObject, date: self.date, usdAmount: self.cryptoAmount * self.selectedStateObject!.currency.priceUsd)
                    self.longer = !self.longer
                    self.mainViewActive = !self.mainViewActive
                }){
                    Text("Sell")
                }
            }
        }
    }
}
}
