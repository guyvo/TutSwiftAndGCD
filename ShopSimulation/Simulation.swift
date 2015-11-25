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
    var customers = Array<Customer>()
   
    init (amountOfCustomers : Int , maxProductsToBuy : Int){
        self.maxProducts = maxProductsToBuy
        
        for id in 1...amountOfCustomers {
            customers.append(Customer(id : id, neededProducts: (Int(arc4random()) % maxProducts)+1))
        }
    }
    
    func getCustomers () -> [Customer]{
        return customers
    }
    
    
    
}