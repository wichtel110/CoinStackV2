//
//  OrderView.swift
//  CoinStackV2
//
//  Created by Michael Heide on 02.07.20.
//  Copyright © 2020 Michael Heide. All rights reserved.
//

import SwiftUI
import CoreData

struct OrderView: View {
    @Environment(\.managedObjectContext) var context

    @FetchRequest var orders: FetchedResults<Order>

    init(){
        let request = Order.fetchRequest(.all)
        _orders = FetchRequest(fetchRequest: request)
    }
    
    var body: some View {
        NavigationView{
            List{
                ForEach(orders, id: \.id){ order in
                OrderItem(order: order)
                }.onDelete(perform: deleteOrder)
            }
            .navigationBarTitle("Order History")
        }
    }
    
    func deleteOrder(at offsets: IndexSet){
        for offset in offsets {
            // find this book in our fetch request
            let order = orders[offset]

            // delete it from the context
            context.delete(order)
        }

        // save the context
        try? context.save()
    }
    

}
