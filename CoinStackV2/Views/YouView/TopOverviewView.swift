//
//  TopOverviewView.swift
//  CoinStackV2
//
//  Created by Michael Heide on 23.06.20.
//  Copyright © 2020 Michael Heide. All rights reserved.
//

import SwiftUI
import CoreData

struct TopOverviewView: View {
    @Environment(\.managedObjectContext) var context
    @ObservedObject var document: PortfolioViewModel
    
    @State private var refreshing = false
    private var didSave =  NotificationCenter.default.publisher(for: .NSManagedObjectContextDidSave)
    
    init(context: NSManagedObjectContext){
        document = PortfolioViewModel(context: context)
    }

    var body: some View {
        HStack{
            ZStack {
                RoundedRectangle(cornerRadius: 4).fill(Color.white)
                    .shadow(color: .shadowColor, radius: 5, x: 0, y: 6)
                VStack{
                    VStack{
                        Text("Portfolio Value".uppercased())
                            .descriptionStyle()
                        Text("\(document.getValue().currencyUS)")
                            .headerStyle()
                    }.padding(.top)
                    Divider().padding(0)
                    
                    HStack{
                        VStack{
                            HStack{
                                Spacer()
                                Text("24H")
                                    .descriptionBoldStyle()
                                Spacer()
                            }
                            HStack{
                                Text("\(document.getGainValue().currencyUS)")
                                    .smallNumberStyle()
                                Image("trending_up")
                                Text(String(format: "%.2f", document.getGain()) + "%")
                                    .smallNumberStyle()
                            }
                        }
                        Divider()
                        VStack{
                            HStack{
                                Spacer()
                                Text("Total".uppercased())
                                    .descriptionBoldStyle()
                                Spacer()
                            }
                            HStack{
                                Text("\(document.getInvestGainValue().currencyUS)")
                                    .smallNumberStyle()
                                Image("trending_up")
                                Text(String(format: "%.2f", document.getInvestGain()) + "%")
                                    .smallNumberStyle()
                            }
                        }
                    }.padding(.bottom, 10)
                }
                
            }
            
        }.frame(height: 150)
            .onReceive(didSave) { _ in
                self.document.fetchAllInvests()
                self.refreshing.toggle()
        }
    }
}

//struct TopOverviewView_Previews: PreviewProvider {
//    static var previews: some View {
//        TopOverviewView()
//    }
//}
