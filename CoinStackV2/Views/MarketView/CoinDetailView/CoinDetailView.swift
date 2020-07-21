//
//  CoinDetailView.swift
//  CoinStackV2
//
//  Created by Michael Heide on 29.06.20.
//  Copyright © 2020 Michael Heide. All rights reserved.
//

import SwiftUI

struct CoinDetailView: View {
    
    @EnvironmentObject var dataService: DataService
    
    @Binding var isPresented: Bool
    @ObservedObject var data: Currency
    

    
    var body: some View {
        VStack{
            //MARK: Header - Start -
            HStack{
                Button(action: {
                    self.isPresented = false
                }){
                   Image(systemName: "chevron.left")
                    .font(.system(size: 32))
                    .foregroundColor(.gray)
                }.frame(width: 65)
                Spacer()
                Image(systemName: "bitcoinsign.circle")
                .font(.system(size: 32))
                .frame(width: 65)

                Spacer()
                Button(action: {
                    self.dataService.setIsWatched(self.data)
                }){
                    Group{
                        if data.isFavorite {
                            VStack{
                                Image("view-disabled")
                                    .foregroundColor(.redIndicator)

                                Text("Unwatch")
                                    .foregroundColor(.redIndicator)
                                       .bodyStyle()
                            }

                        }else{
                            VStack{
                                Image("view-enabled")
                                Text("Watch")
                                    .foregroundColor(.blueIndicator)
                                       .bodyStyle()
                            }
                        }
                    }
                }.frame(width: 65)
            }
            //MARK: Header - End -
                Text(self.data.name)
                .titleStyle()
                Text(self.data.symbol)
                .descriptionStyle()
                HStack{
                    Text("\(self.data.priceUsd.currencyUS)")
                    .titleStyle()
                    Image("trending_up")
                    .font(.system(size: 36))
                }.padding(.top, 25)
                
                
                HStack{
                    //24
                    VStack{
                        Text("24h")
                        .descriptionStyle()
                        .padding()

                        Text(String(format: "%.2f", self.data.changePercent24Hr) + "%")
                            .foregroundColor(.redIndicator)
                        .smallNumberStyle()
                    }
                    Divider()
                    VStack{
                        Text("7 DAYS")
                        .descriptionStyle()
                        .padding()

                        Text(String(format: "%.2f", self.data.changePercent24Hr) + "%")
                            .foregroundColor(.redIndicator)

                        .smallNumberStyle()

                    }
                    //1Month
                    Divider()
                    VStack{
                        Text("1 MONTH")
                        .descriptionStyle()
                        .padding()

                        Text(String(format: "%.2f", self.data.changePercent24Hr) + "%")
                            .foregroundColor(.redIndicator)

                        .smallNumberStyle()

                    }
                    //1 Year
                    Divider()
                    VStack{
                        Text("1 YEAR")
                        .descriptionStyle()
                        .padding()

                        Text(String(format: "%.2f", self.data.changePercent24Hr) + "%")
                            .foregroundColor(.redIndicator)

                        .smallNumberStyle()
                    }
                }.frame(height: 50)
                    .padding(.bottom, 20)
            
                Text("MARKET CAP")
                    .descriptionStyle()
                Text("\(self.data.marketCapUsd.currencyUS)")
                    .bodyLightStyle()
            
            Spacer()
        }.padding(.horizontal, 10)
            .padding(.vertical, 30)
    }
}
