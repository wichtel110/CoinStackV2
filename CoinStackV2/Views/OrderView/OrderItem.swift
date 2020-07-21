//
//  OrderItem.swift
//  CoinStackV2
//
//  Created by Michael Heide on 02.07.20.
//  Copyright © 2020 Michael Heide. All rights reserved.
//

import SwiftUI

struct OrderItem: View {
    
    var order: Order
    var dateFormatterDays: DateFormatter
    var dateFormatterTime: DateFormatter
    
    init(order: Order){
        self.order = order
        self.dateFormatterDays = DateFormatter()
        self.dateFormatterTime = DateFormatter()
        self.dateFormatterDays.dateFormat = "d.MM.y"
        self.dateFormatterTime.dateFormat = "HH:mm"
    }
    
    var body: some View {
        HStack{
            if order.orderType == "BUY"{
                Image("plus-circle").colorInvert()
                    .font(.system(size: 32))
            } else if order.orderType == "SELL"{
                Image("rocket").colorInvert()
                    .font(.system(size: 32))
            }
            VStack(alignment: .leading){
                Text("\(order.currency.name)")
                .bodyStyle()
                Text("price: \(order.price.currencyUS)")
                .descriptionStyle()
            }.padding(.horizontal, 10)
            Spacer()
            VStack(alignment: .trailing){
                    Text("\(self.dateFormatterDays.string(from: order.date!))").bodyStyle()
                    Text("\(self.dateFormatterTime.string(from: order.date!))").bodyStyle()
            }
        }.frame(height: 50)
    }
}
