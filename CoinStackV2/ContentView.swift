//
//  ContentView.swift
//  CoinStackV2
//
//  Created by Michael Heide on 02.06.20.
//  Copyright © 2020 Michael Heide. All rights reserved.
//

import SwiftUI
import PartialSheet
import CoreData


enum Filter: String, CaseIterable {
    case all, fav
}

struct ContentView: View {
    @EnvironmentObject var dataService: DataService
    @Environment(\.managedObjectContext) var context

    @FetchRequest var assets: FetchedResults<Currency>
    
    init() {
        let request = Currency.fetchRequest(.all)
        _assets = FetchRequest(fetchRequest: request)
    }
    
    var sheetStyle: PartialSheetStyle = PartialSheetStyle(backgroundColor: Color.black,
                             handlerBarColor: Color(UIColor.systemGray2),
                             enableCover: true,
                             coverColor: Color.black.opacity(0.4),
                             blurEffectStyle: nil
    )
    
    @State private var currentFilter = Filter.all
    
    var body: some View {
        GeometryReader{ geometry in
            TabView{
                // MARK: Personal View Section
                YouMainView().environmentObject(self.dataService).environment(\.managedObjectContext, self.context)
                    .tabItem{
                        Image(systemName: "person.crop.circle")
                        Text("You")
                    }
          
                // MARK: Order View Section
                OrderView().environment(\.managedObjectContext, self.context)
                    .tabItem{
                        Image(systemName: "timer")
                        Text("Orders")
                }
                // MARK: Market View Section
                NavigationView {
                    List{
                        Picker("segment", selection: self.$currentFilter) {
                            ForEach(Filter.allCases, id: \.self) {
                                Text(LocalizedStringKey($0.rawValue.capitalized))
                            }
                        }.pickerStyle(SegmentedPickerStyle())
                        
                        FilterList(filter: self.$currentFilter, size: geometry.size).environmentObject(self.dataService)
//                       
                    }.navigationBarTitle(Text("Markets"))
                        //MARK: TODO - Throws Warning UITableView was told to layout its visible cells
                        .onAppear {
                            //UITableView.appearance().separatorStyle = .none
                        }.onDisappear {
                            //UITableView.appearance().separatorStyle = .singleLine
                    }
                }
                .tabItem{
                    Image(systemName: "chart.bar")
                    Text("Markets")
                }
            }.addPartialSheet(style: self.sheetStyle)
            .navigationViewStyle(StackNavigationViewStyle())
        }
    }
}
