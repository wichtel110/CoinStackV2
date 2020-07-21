//
//  FilterList.swift
//  CoinStackV2
//
//  Created by Michael Heide on 28.06.20.
//  Copyright © 2020 Michael Heide. All rights reserved.
//

import SwiftUI
import CoreData

struct FilterList: View {
    @FetchRequest var assets: FetchedResults<Currency>
    var size: CGSize
    @EnvironmentObject var dataService: DataService


    init(filter: Binding<Filter>, size: CGSize){
        var request: NSFetchRequest<Currency>
        self.size = size
        switch filter.wrappedValue{
        case .all:
            request = Currency.fetchRequest(.all)
        case .fav:
            request = Currency.fetchRequest(NSPredicate(format: "isFavorite == %@", NSNumber(value: true)))
        }
        _assets = FetchRequest(fetchRequest: request)
    }
    
    var body: some View {
         ForEach(self.assets, id: \.id){ data in
            // MARK: TODO Sheet or Detailed View
            ItemView(data: data, size: self.size).listRowInsets(EdgeInsets()).environmentObject(self.dataService)
         }.id(UUID())
    }
}

//struct FilterList_Previews: PreviewProvider {
//    static var previews: some View {
//        FilterList()
//    }
//}
