//
//  BuyDetailView.swift
//  CoinStackV2
//
//  Created by Michael Heide on 30.06.20.
//  Copyright © 2020 Michael Heide. All rights reserved.
//

import SwiftUI
import CoreData
import PartialSheet

struct BuyDetailView: View {
    @ObservedObject var modelView: BuyDetailModelView
    @EnvironmentObject var partialSheetManager : PartialSheetManager
    
    @FetchRequest var assets: FetchedResults<Currency>
    
    @Binding var longer: Bool
    @Binding var mainViewActive: Bool
    
    
    init(context: NSManagedObjectContext, longer: Binding<Bool> ,mainViewActive: Binding<Bool>){
        UITableView.appearance().backgroundColor = .clear
        let request = Currency.fetchRequest(.all)
        _assets = FetchRequest(fetchRequest: request)
        self.modelView = BuyDetailModelView(context: context)
        _longer = longer
        _mainViewActive = mainViewActive
    }
    
    @State private var selectedStateString: String = ""
    @State private var selectedStateObject: Currency?
    
    @State private var textUsd: String = "USD amount"
    @State private var usdValue = 0.0
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
                    ForEach(self.assets, id: \.id){ data in
                        Text("\(data.symbol)").tag(data.symbol)
                    }
                }
                .onReceive([self.selectedStateString].publisher.first()) { (value) in
                    self.selectedStateObject = self.assets.first(where: {
                        $0.symbol == value
                    })
                }
            if self.selectedStateObject != nil{
                Text("\(self.selectedStateObject!.name) currrent value: \((self.selectedStateObject?.priceUsd.currencyUS)!)")
                Section{
                    Text("USD Amount").bold()
                    TextField(textUsd, value: $usdValue, formatter: self.numberFormatter)
                }
                
                Section{
                    Text("Crypto Amount").bold()
                    Text("\(usdValue / self.selectedStateObject!.priceUsd)")
                }
                
                
            }
            if self.selectedStateObject != nil && usdValue > 0{
                Button(action:{
                    self.modelView.createNewOrder(coinAmount: (self.usdValue / self.selectedStateObject!.priceUsd), currency: self.selectedStateObject, date: self.date, usdAmount: self.usdValue)
                    
                    self.longer = !self.longer
                    self.mainViewActive = !self.mainViewActive
                    
                }){
                    Text("Bought")
                    
                }
            }
        }
    }
}
}
