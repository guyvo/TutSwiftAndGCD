//
//  Customer.swift
//  ShopSimulation
//
//  Created by Guy Van Overtveldt on 21/10/15.
//  Copyright © 2015 Guy Van Overtveldt. All rights reserved.
//

import Foundation

// momentums of a customer
private enum stateCustomer{
    case
    ARRIVED,
    ENTERED_SHOP,
    CHART_TAKEN,
    IN_SEARCH,
    PRODUCT_TAKEN,
    WAIT_PAYDESK,
    PRODUCTS_OUT_CHART,
    PRODUCTS_IN_CHART,
    PAYED,
    CHART_DROPPED,
    LEFT_SHOP
}

class Customer{
    
    var id : Int
    let amountOfProductsNeeded : Int
    
    private var state = stateCustomer.ARRIVED {
        willSet (value) {
            // notify here
            print("customer_\(id) state \(state) will change into \(value)")
        }
        didSet{
            // notify here
            print("customer_\(id) state changed into \(state)")
        }
    }
    
    init (id : Int,neededProducts : Int){
        amountOfProductsNeeded = neededProducts
        self.id = id
    }
    
    func drivetoShop(){
        randomSleep()
        state = stateCustomer.ARRIVED
    }
    
    func takeChart(){
        randomSleep()
        state = stateCustomer.ENTERED_SHOP
        randomSleep()
        state = stateCustomer.CHART_TAKEN
    }
    
    func searchProduct(){
        state = stateCustomer.IN_SEARCH
        randomSleep()
    }
    
    func takeProduct(){
        state = stateCustomer.PRODUCT_TAKEN
        randomSleep()
    }
    
    func buyProducts(){
        for _ in 1...amountOfProductsNeeded{
            searchProduct()
            takeProduct()
        }
    }
    
    func waitPaydesk(){
        state = stateCustomer.WAIT_PAYDESK
    }
    
    func putOnBelt(){
        randomSleep()
        state = stateCustomer.PRODUCTS_OUT_CHART
    }
    
    func putInChart(){
        randomSleep()
        state = stateCustomer.PRODUCTS_IN_CHART
    }
    
    func hasPayed(){
        randomSleep()
        state = stateCustomer.PAYED
    }
    
    func dropChart(){
        randomSleep()
        state = stateCustomer.CHART_DROPPED
    }
    
    func leaveShop(){
        randomSleep()
        state = stateCustomer.LEFT_SHOP
    }
}