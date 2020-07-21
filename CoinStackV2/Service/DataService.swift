//
//  RestService.swift
//  CoinStackV2
//
//  Created by Michael Heide on 02.06.20.
//  Copyright © 2020 Michael Heide. All rights reserved.
//

import SwiftUI
import Foundation
import Combine
import CoreData

class DataService: ObservableObject {
    
    private let restUrl: URL?
    private let timeInterval: TimeInterval
    private var fetchTimer: Timer?
    private let context: NSManagedObjectContext
    
    private var websocketUrl: URL?
    private let urlSession = URLSession(configuration: .default)
    private var webSocketTask: URLSessionWebSocketTask?

    @Published var receivedData: Root = Root(data: [Asset]())
    //@Published private(set) var backgroundImage: UIImage?

    var updateCancellable: Cancellable?
    
    init(timeInterval: TimeInterval, restUrl: String = "https://api.coincap.io/v2/assets", websocketUrl: String = "wss://ws.coincap.io/prices?assets=ALL", context: NSManagedObjectContext){
        self.restUrl = URL(string: restUrl)
        self.websocketUrl = URL(string: websocketUrl)
        self.context = context
        self.timeInterval = timeInterval
        self.callApi()

        self.updateCancellable = $receivedData.sink(receiveValue: { root in
            for asset in root.data {
                Currency.createByAsset(asset, context: self.context)
                //Invest.refreshInvest(context: context)
            } 
            
        })
    }
    
    func setIsWatched(_ assetItem: Currency){
        let currency = Currency.toggleFav(assetItem, context: self.context)
        print("\(String(describing: currency))")
    }
    
    func setIsSwipped(_ assetItem: Asset){
        if let row = self.receivedData.data.firstIndex(where: { $0.id == assetItem.id}){
            self.receivedData.data[row].isSwipped.toggle()
        }
    }
    
    
    func callApi(){
    
        URLSession.shared.dataTask(with: self.restUrl!) { (data, response, error) in
        
            // Check if Error
            if let safeError = error {
                print("Error happend during API Call: \(safeError)")
                return
            }
            // Check Data
            if let safeData = data {
                //try to handle the Data
                let decodedData = try! JSONDecoder().decode(Root.self, from: safeData)
                
                //Sync Threads
                DispatchQueue.main.async {
                    self.receivedData = decodedData
//                    //self.getWebsocketData()
                }
            }
            }.resume()
        
        self.fetchTimer = Timer.scheduledTimer(withTimeInterval: self.timeInterval, repeats: false, block: { (Timer) in
            self.callApi()
        })
    }
    
//    func getCoinImage(_ asset: Currency) -> UIImage? {
//        let imageUrl: URL = URL(string: asset.imgUrl!)!
//    
//        DispatchQueue.global(qos: .userInitiated).async {
//            if let imageData = try? Data(contentsOf: imageUrl) {
//                DispatchQueue.main.async {
//                    return UIImage(data: imageData)
//                }
//            }
//        }
//        
//        return nil
//    }
    
    
    func getWebsocketData(){
        self.webSocketTask = urlSession.webSocketTask(with: self.websocketUrl!)
        webSocketTask?.resume()
        self.receiveMessage()
    }
    
    func updateData(key: String, value: String){
        if let row = self.receivedData.data.firstIndex(where:{$0.id == key}) {
            if (Double(self.receivedData.data[row].priceUsd)! - Double(value)!) > 0.005{
                self.receivedData.data[row].priceUsd = value
            }
        }
    }
    
    private func receiveMessage() {
        self.webSocketTask?.receive {[weak self] result in
                switch result {
                case .failure(let error):
                    print("Error in receiving message: \(error)")
                case .success(.string(let str)):
                    if(!str.isEmpty){
                      do {
                        
                        let data = Data(str.utf8)
                        let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                        DispatchQueue.main.async {
                            for (key, value) in json {
                                //print(key, value)
                                self?.updateData(key: key, value: value as! String)
                            }
                        }
                        sleep(5)
                        } catch  {
                            print("error is \(error.localizedDescription)")
                        }
                    }
                    self?.receiveMessage()

                default:
                    print("default")
                }
            }
    }
}
