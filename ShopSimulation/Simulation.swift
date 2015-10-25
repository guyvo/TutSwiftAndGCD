//
//  Simulation.swift
//  ShopSimulation
//
//  Created by Guy Van Overtveldt on 21/10/15.
//  Copyright © 2015 Guy Van Overtveldt. All rights reserved.
//

import Foundation

class Simulation {
    
    let maxProducts : Int
    
    init (maxProductsToBuy : Int){
        self.maxProducts = maxProductsToBuy
    }
    
    func createCustomers (amount : Int) -> [Customer]{
        
        var customers = [Customer]()
        
        for id in 1...amount {
            
            customers.append(Customer(id : id, neededProducts: (Int(arc4random()) % maxProducts)+1))
            
        }
        return customers
    }
}