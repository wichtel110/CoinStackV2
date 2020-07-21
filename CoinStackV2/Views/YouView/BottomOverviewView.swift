//
//  BottomOverviewView.swift
//  CoinStackV2
//
//  Created by Michael Heide on 23.06.20.
//  Copyright © 2020 Michael Heide. All rights reserved.
//

import SwiftUI
import PartialSheet
import CoreData

struct BottomOverviewView: View {
    @EnvironmentObject var partialSheetManager : PartialSheetManager
    @Environment(\.managedObjectContext) var context
    @ObservedObject var document: BottomOverViewModel

    //@FetchRequest var invests: FetchedResults<Invest>

    init(context: NSManagedObjectContext){
        document = BottomOverViewModel(context: context)
        
       // let request = Invest.fetchRequest(.all)
       // _invests = FetchRequest(fetchRequest: request)
    }
    
    @State private var refreshing = false
    private var didSave =  NotificationCenter.default.publisher(for: .NSManagedObjectContextDidSave)
    
    
    var body: some View {
        List(){
            ForEach(document.invests ?? [], id: \.self){ data in
                HStack{
                    Image(systemName: "bitcoinsign.circle")
                    .font(.system(size: 32))
                        VStack(alignment: .leading){
                           Text("\(data.currency.name)").bodyStyle()
                           Text("\(data.symbol)").descriptionStyle()
                       }
                    .frame(width: 75, alignment: .leading)
                    VStack(alignment: .leading){
                        Text("\(data.cryptoAmount)").bodyStyle()
                        Text("\(data.currency.priceUsd)").descriptionStyle()
                    }
                    Spacer()
                    VStack(alignment: .trailing){
                        Text("\((data.cryptoAmount * data.currency.priceUsd).currencyUS)").bodyStyle()
                        if (data.currency.changePercent24Hr >= 0.0) {
                                Text(String(format: "%.2f", data.currency.changePercent24Hr ))
                                .font(.system(size: 11, weight: .bold))
                                .foregroundColor(Color.green)
                        } else {
                                Text(String(format: "%.2f", data.currency.changePercent24Hr ))
                                .font(.system(size: 11, weight: .bold))
                                .foregroundColor(Color.red)
                        }
                    }
                }
            }
            
            Button(action: {
                self.partialSheetManager.showPartialSheet({
                    print("normal sheet dismissed")
                }) {
                    SheetView().environmentObject(self.partialSheetManager).environment(\.managedObjectContext, self.context)
                }
            }, label: {
                ListButton()
            })
        }.onReceive(didSave) { _ in
            self.document.fetchAllInvests()
            self.refreshing.toggle()
        }
    }
}


// Button For Opening Sheet
struct ListButton: View {
    var body: some View{
        HStack{
            Spacer()
            VStack{
                Image(systemName: "plus.circle")
                    .font(.system(size: 22, weight: .regular))
                    .foregroundColor(.newSecondaryColorBluish)                    .padding(2)
                Text("Add new transaction")
                    .bodyLightStyle()
                    .padding(0)
            }
            Spacer()
        }
        .padding()
        .overlay(
            RoundedRectangle(cornerRadius: 5)
                .stroke(Color.newSecondaryColorBluish, style: StrokeStyle(lineWidth: 2, dash: [5]))
            
        )
        
    }
}





