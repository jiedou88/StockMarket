//
//  DBModel.swift
//  StocksApp
//
//  Created by administrator on 8/10/18.
//  Copyright © 2018 administrator. All rights reserved.
//

import Foundation
import CoreData //import core data API
class DBModel{
    // core data stack
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "StocksApp")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    //save item to db
    func saveToDB(symbol:String,name:String){
        let results = fetchBySymbol(symbol: symbol)
        if (results.count == 0){
            let stock = NSEntityDescription.insertNewObject(forEntityName: "Stock", into: persistentContainer.viewContext) as! Stock
            
            stock.name = name
            stock.symbol = symbol
            saveContext()
        }
        
    }
    // Core Data Saving
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    func fetchBySymbol(symbol:String)->NSMutableArray{
        let fetchStocksBySymbol :NSFetchRequest<Stock> = Stock.fetchRequest()
        
        if(!symbol.isEmpty){
            fetchStocksBySymbol.predicate = NSPredicate(format: "symbol == %@", symbol)
        }
        
        let allStocks = NSMutableArray()
        
        do{
            let result = try persistentContainer.viewContext.fetch(fetchStocksBySymbol)
            
            if (!result.isEmpty){
                
                for r in result{
                    allStocks.add(r)
                }
                
            }
        }catch{}
        
        return allStocks
    }
    
    
    func fetchAllStocks() -> NSMutableArray{
        let allStocks = NSMutableArray()
        
        let fetchStock :NSFetchRequest<Stock> = Stock.fetchRequest()
        
        do{
            let stocks = try persistentContainer.viewContext.fetch(fetchStock)
            
            for stock in stocks {
                allStocks.add(stock)
            }
        }catch{}
        
        return allStocks
    }
    func insertStock(name:String, symbol:String) {
        
        
        let results = fetchBySymbol(symbol: symbol)
        if (results.count == 0){
            let stock = NSEntityDescription.insertNewObject(forEntityName: "Stock", into: persistentContainer.viewContext) as! Stock
            
            stock.name = name
            stock.symbol = symbol
            saveContext()
        }
    }
    
}
