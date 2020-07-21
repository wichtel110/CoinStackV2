//
//  ItemView.swift
//  CoinStackV2
//
//  Created by Michael Heide on 12.06.20.
//  Copyright © 2020 Michael Heide. All rights reserved.
//

import SwiftUI
import CoreData

struct ItemView: View {
    
    @ObservedObject var data: Currency
    var size: CGSize
    
    @EnvironmentObject var dataService: DataService
    
    
    
    @State private var isSwipped: Bool = false
    
    var backgroundColor: Color {
        data.isFavorite ? .lightRed : .lightBlue
    }
    
    @State private var steadyStateOffset: CGSize = CGSize(width: 0, height: 0)
    @State var isPresented = false
    
    
    private var offset: CGSize {
        steadyStateOffset
    }
    
    var body: some View {
        ZStack{
            Rectangle().foregroundColor(.white)
            HStack{
                Group{
                    Text("\(self.data.rank)").padding(.leading, 5)
                    Image(systemName: "bitcoinsign.circle")
                        .font(.system(size: 32))
                }
                Group{
                    VStack(alignment: .leading){
                        //Coin Name
                        Text(self.data.name)
                            .font(.system(size: 14, weight: .bold))
                        
                        Text(self.data.symbol)
                                .font(.system(size: 11, weight: .bold))
                                .foregroundColor(Color.gray)
                    }
                }
                Spacer()
                VStack(alignment: .trailing){
                    //Coin ammount
                    Text("$" + String(format: "%.2f", self.data.priceUsd ) )
                        .font(.system(size: 14, weight: .bold))

                    if (self.data.changePercent24Hr >= 0.0) {
                        Text(String(format: "%.2f", self.data.changePercent24Hr ))
                            .font(.system(size: 11, weight: .bold))
                            .foregroundColor(Color.green)
                    } else {
                        Text(String(format: "%.2f", self.data.changePercent24Hr ))
                            .font(.system(size: 11, weight: .bold))
                            .foregroundColor(Color.red)
                    }

                }.padding(.trailing, 5)
                    ZStack{
                        Rectangle()
                            .foregroundColor(backgroundColor)
                            .frame(width: 100, height: 64.0)
                        VStack{
                            Group{
                                if data.isFavorite {
                                    Image("view-disabled")
                                    Text("Unwatch")
                                        .foregroundColor(.redIndicator)
                                    .bodyStyle()
                                        
                                }else{
                                    Image("view-enabled")
                                    Text("Watch")
                                        .foregroundColor(.blueIndicator)
                                    .bodyStyle()
                                    
                                }
                            }
                        }
                    }.gesture(TapGesture(count: 1).onEnded() {
                        self.dataService.setIsWatched(self.data)
    
                    })
            }
            .frame(width: self.size.width + 100, height: 64.0, alignment: .leading)
            .onTapGesture {
                self.isPresented.toggle()
            }.sheet(isPresented: $isPresented) {
                CoinDetailView(isPresented: self.$isPresented, data: self.data)
                    .environmentObject(self.dataService)
            }
        }
                .offset(self.offset)
                .gesture(self.swipeGesture(data: self.data))
    }
    
    func swipeGesture(data: Currency) -> some Gesture {
        return DragGesture(minimumDistance: 20).onEnded { _ in
            self.isSwipped.toggle()
            withAnimation {
                if self.isSwipped {
                    self.steadyStateOffset.width = 0
                }else {
                    self.steadyStateOffset.width = -100
                }
            }
        }
        
    }
    
    func tappingGesture(data: Currency) -> some Gesture {
        return TapGesture(count: 1).onEnded() {
            self.isSwipped.toggle()
            withAnimation {
                if self.isSwipped {
                    self.steadyStateOffset.width = 0
                }else {
                    self.steadyStateOffset.width = -100
                }
            }
        }
    }
}




struct ItemView_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
