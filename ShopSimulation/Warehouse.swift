//
//  Warehouse.swift
//  ShopSimulation
//
//  Created by Guy Van Overtveldt on 21/10/15.
//  Copyright © 2015 Guy Van Overtveldt. All rights reserved.
//

import Foundation

class Warehouse{
    
    var products : [Product]
    
    // no sense
    init (amountOfProducts : Int){
        products = [Product](count: amountOfProducts, repeatedValue: Product(price: 0.0))
    }
    
    // add all kind of products
    init (products : [Product]){
        self.products = products
    }
}


