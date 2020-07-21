//
//  BottomOverViewModel.swift
//  CoinStackV2
//
//  Created by Michael Heide on 09.07.20.
//  Copyright © 2020 Michael Heide. All rights reserved.
//

import SwiftUI
import CoreData
import Combine

class BottomOverViewModel: ObservableObject {
    
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
}
