//
//  DetailViewController.swift
//  StocksApp
//
//  Created by administrator on 8/14/18.
//  Copyright © 2018 administrator. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    let key = "TEUK0SW0QEMQ3DZ7"
    var urlString = String()
    var symbol = String()
    
    @IBOutlet weak var symbolLabel: UILabel!
    @IBOutlet weak var openLabel: UILabel!
    @IBOutlet weak var highLabel: UILabel!
    @IBOutlet weak var lowLabel: UILabel!
    @IBOutlet weak var closeLabel: UILabel!
    @IBOutlet weak var volumeLabel: UILabel!
    
    @IBAction func goBack(_ sender: Any) {
        dismiss(animated: false, completion: nil)
    }
    
    @IBAction func reloadDetail(_ sender: Any) {
        getDetail()
    }
    
    func getDetail(){
        urlString = "https://www.alphavantage.co/query?function=TIME_SERIES_INTRADAY&symbol=\(symbol)&interval=1min&apikey=\(key)"
        let url : URL = URL(string: urlString)!
        
        let downloader = Downloader(url: url)
        downloader.delegate = self
        downloader.getDetail(forSymbol: symbol)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        symbolLabel.text = self.symbol
        getDetail()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

extension DetailViewController:DownloaderDelegate{
    
    func downloaderDidFinishWithDetail(open: String, high: String, low: String, close: String, volume: String) {
        self.openLabel.text = open
        self.highLabel.text = high
        self.lowLabel.text = low
        self.closeLabel.text = close
        self.volumeLabel.text = volume
    }
}
