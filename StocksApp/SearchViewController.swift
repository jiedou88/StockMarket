//
//  SearchViewController.swift
//  StocksApp
//
//  Created by administrator on 8/14/18.
//  Copyright © 2018 administrator. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController,UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate,yahooSearchDelegate{
    var results = NSArray()
    var yahooModel = YahooModel.init()
    let databaseHandler = DBModel()
    @IBOutlet weak var resultTable: UITableView!


    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        self.yahooModel.searchYahoo(forUserText: searchText)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        let item = self.results[indexPath.row] as! NSDictionary
        
        cell?.textLabel?.text = (item.object(forKey: "symbol") as! String)
        cell?.detailTextLabel?.text = (item.object(forKey: "name" ) as! String)
        
        return cell!
        
    }
    
    func yahooDidFinish(withResults YahooResults: [Any]!) {
        self.results = YahooResults! as NSArray
        self.resultTable.reloadData()
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
        let item = self.results[indexPath.row] as! NSDictionary
        let n = item.object(forKey: "name") as! String
        let s = item.object(forKey: "symbol") as! String
        
        databaseHandler.insertStock(name: n, symbol: s)
        
        //self.view.window!.rootViewController?.dismiss(animated: false, completion: nil)
        let controller = storyboard?.instantiateViewController(withIdentifier: "Symbol")
        self.navigationController!.pushViewController(controller!, animated: true)
        
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.yahooModel.delegate = self
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

}
