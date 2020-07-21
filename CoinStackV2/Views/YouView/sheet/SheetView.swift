//
//  SheetView.swift
//  CoinStackV2
//
//  Created by Michael Heide on 02.07.20.
//  Copyright © 2020 Michael Heide. All rights reserved.
//

import SwiftUI
import PartialSheet

struct SheetView: View {
    @EnvironmentObject var partialSheetManager : PartialSheetManager
    @Environment(\.managedObjectContext) var context

    @State private var longer: Bool = false
    @State private var text: String = "some text"
    
    @State private var mainViewActive = true
    @State private var buyViewActive = false
    @State private var sellViewActive = false
    @State private var transActionViewActive = false
    
    
    
    
    var body: some View {
        VStack {
            Group {
                if self.mainViewActive {
                    Text("Choose transaction type".uppercased())
                        .font(.caption)
                        .fontWeight(.bold)
                        .colorInvert()
                    HStack(alignment: .center){
                        Spacer()
                        VStack(alignment: .center){
                            Image("plus-circle")
                            Text("Buy")
                                .fontWeight(.bold)
                                .colorInvert()
                        }.frame(width:100)
                            .onTapGesture {
                                self.longer = !self.longer
                                self.buyViewActive = !self.buyViewActive
                                self.mainViewActive = !self.mainViewActive
                        }
                        VStack(alignment: .center){
                            Image("rocket")
                            Text("Sell")
                                .fontWeight(.bold)
                                .colorInvert()

                        }.frame(width:100)
                            .onTapGesture {
                                self.longer = !self.longer
                                self.sellViewActive = !self.sellViewActive
                                self.mainViewActive = !self.mainViewActive
                        }
                        VStack(alignment: .center){
                            Image("swap")
                            Text("Transfer")
                                .fontWeight(.bold)
                                .colorInvert()
                        }.frame(width:100)
                            .onTapGesture {
                                self.longer = !self.longer
                                self.transActionViewActive = !self.transActionViewActive
                                self.mainViewActive = !self.mainViewActive
                        }
                        Spacer()
                    }
                    .padding()
                    .frame(height: 50)
                }
            }
            if self.longer {
                // Top
                NavigationView {
                    VStack{
                        HStack{
                            Button(action: {
                                self.longer = !self.longer
                                self.mainViewActive = !self.mainViewActive
                                
                                if self.transActionViewActive{
                                    self.transActionViewActive = !self.transActionViewActive
                                }else if self.buyViewActive{
                                    self.buyViewActive = !self.buyViewActive
                                }else if self.sellViewActive{
                                    self.sellViewActive = !self.sellViewActive
                                }
                            }) {
                                Image(systemName: "chevron.left")
                                    .font(.system(size: 32))
                                    .foregroundColor(.gray)
                            }
                            
                            if self.buyViewActive{
                                Text("Buy Crypto").foregroundColor(.black).headerStyle().padding(.horizontal,10)
                            }else if self.sellViewActive{
                                Text("Sell Crypto").foregroundColor(.black).headerStyle().padding(.horizontal,10)
                            }else {
                                Text("Transaction").foregroundColor(.black).headerStyle().padding(.horizontal,10)
                            }
                            
                            Spacer()
                        }
                        if self.buyViewActive{
                            BuyDetailView(context: context, longer: $longer, mainViewActive: $mainViewActive)
                        }
                        if self.sellViewActive{
                            SellDetailView(context: context, longer: $longer, mainViewActive: $mainViewActive)
                        }
                        if self.transActionViewActive{
                            VStack {
                                Text("More settings here...")
                            }.colorInvert()
                        }
                        Spacer()
                    }.navigationBarTitle("") //this must be empty
                        .navigationBarHidden(true)
                        .navigationBarBackButtonHidden(true)

                }.colorInvert()
                    .frame(height: 600)

            }

        }.padding()
        
        
    }
}
