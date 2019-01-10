//
//  ViewController.swift
//  StocksApp
//
//  Created by administrator on 8/10/18.
//  Copyright © 2018 administrator. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate {
    
   
    @IBOutlet weak var displayTable: UITableView!
    var allStocks=NSMutableArray()
    let databaseHandler=DBModel()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return 3
        return allStocks.count
    }
    //
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=self.displayTable.dequeueReusableCell(withIdentifier: "cell")
        let item=self.allStocks[indexPath.row] as! Stock
        //cell.detailTextLabel?.text="ssss"
        cell?.detailTextLabel?.text=item.symbol
        //cell.textLabel?.text="dddd"
        cell?.textLabel?.text=item.name
        return cell!
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.allStocks = self.databaseHandler.fetchAllStocks()
        self.displayTable.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //self.allStocks=self.databaseHandler.fetchAllStocks()
        //self.displayTable.reloadData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "showDetail"){
            let dvc = segue.destination as! DetailViewController
            let index = self.displayTable.indexPathForSelectedRow?.row
            let item = self.allStocks[index!] as! Stock
            dvc.symbol = item.symbol!
        }
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        self.allStocks = self.databaseHandler.fetchBySymbol(symbol: searchText)
        self.displayTable.reloadData()
    }}

