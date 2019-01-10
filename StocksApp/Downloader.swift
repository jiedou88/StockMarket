//
//  Downloader.swift
//  StocksApp
//
//  Created by administrator on 8/10/18.
//  Copyright © 2018 administrator. All rights reserved.
//
// call yahoo API
import Foundation
//import CodingKey


protocol DownloaderDelegate {
    func downloaderDidFinishWithDetail(open:String, high:String, low:String, close:String, volume:String)
}

//struct StockStats: Decodable{
struct StockStats{
    let open: String?
    let close: String?
    let high: String?
    let low: String?
    let volume: Int?
    
    let lastRefreshed: String?
    
    //enum CodingKeys: String, CodingKey {
    enum CodingKeys: String {
        case open = "1. open"
        case close = "4. close"
        case high = "2. high"
        case low = "3. low"
        case volume = "5. volume"
        case lastRefreshed = "3. Last Refreshed"
    }
}
class Downloader{
    let url : URL
    var delegate : DownloaderDelegate? = nil
    
    init(url:URL){
        self.url = url
    }
    

    func getData(url : URL , completionHandler : @escaping (Data)->()) {
        
        let config = URLSessionConfiguration.default
        let sessin = URLSession(configuration: config)
        
        let task = sessin.dataTask(with: self.url) { (data, respons, error) in
            if error == nil {
                if let myData = data{
                    
                    completionHandler(myData)
                }
            }
        }
        task.resume()
    }
    
    func getDetail(forSymbol : String)  {
        self.getData(url: self.url) { (JsonData) in
            // third
            do {
                let jsonObject = try JSONSerialization.jsonObject(with: JsonData, options: []) as? NSDictionary
                if((jsonObject?.count) != 1)
                {
                    let time = jsonObject?.value(forKeyPath: "Meta Data."+StockStats.CodingKeys.lastRefreshed.rawValue) as! String
                
                    let open = jsonObject?.value(forKeyPath: "Time Series (1min)."+time+"."+StockStats.CodingKeys.open.rawValue) as! String
                    let high = jsonObject?.value(forKeyPath: "Time Series (1min)."+time+"."+StockStats.CodingKeys.high.rawValue) as! String
                    let low = jsonObject?.value(forKeyPath: "Time Series (1min)."+time+"."+StockStats.CodingKeys.low.rawValue) as! String
                    let close = jsonObject?.value(forKeyPath: "Time Series (1min)."+time+"."+StockStats.CodingKeys.close.rawValue) as! String
                    let volume = jsonObject?.value(forKeyPath: "Time Series (1min)."+time+"."+StockStats.CodingKeys.volume.rawValue) as! String
                
                    DispatchQueue.main.async {
                        self.delegate?.downloaderDidFinishWithDetail(open:open, high:high, low:low, close:close, volume:volume)
                }
              }
            }
            catch{}
        }
    }
}
