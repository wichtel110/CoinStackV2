//
//  YouMainView.swift
//  CoinStackV2
//
//  Created by Michael Heide on 23.06.20.
//  Copyright © 2020 Michael Heide. All rights reserved.
//

import SwiftUI

struct YouMainView: View {
    @Environment(\.managedObjectContext) var context

    
    var body: some View {
            
            VStack{
                HStack{
                    VStack{
                        Text("Your Portfolio")
                            .headerStyle()
                    }.padding(.leading, 5)
                    Spacer()
                }.padding(.top,15)
                VStack{
                    //MARK: - Top Layout Overview
                    TopOverviewView(context: context)
                        .padding(.horizontal)
                        .padding(.bottom)
                }
                Spacer()
                VStack{
                    //MARK: - Bottom Layout List
                    BottomOverviewView(context: context).environment(\.managedObjectContext, self.context)
                }
            }
                

    }
}

struct YouMainView_Previews: PreviewProvider {
    static var previews: some View {
        YouMainView()
    }
}
