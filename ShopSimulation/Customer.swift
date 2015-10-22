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
    
    let amountOfProductsNeeded : Int
    
    private var state = stateCustomer.ARRIVED {
        willSet (value) {
            // notify here
            print("state \(state) will change into \(value)")
        }
        didSet{
            // notify here
            print("state changed into \(state)")
        }
    }
    
    init (neededProducts : Int){
        amountOfProductsNeeded = neededProducts
    }
    
    func drivetoShop(){
        randomSleep()
        stateCustomer.ARRIVED
    }
    
    func takeChart(){
        randomSleep()
        stateCustomer.ENTERED_SHOP
        randomSleep()
        stateCustomer.CHART_TAKEN
    }
    
    func searchProduct(){
        stateCustomer.IN_SEARCH
        randomSleep()
    }
    
    func takeProduct(){
        stateCustomer.PRODUCT_TAKEN
        randomSleep()
    }
    
    func buyProducts(){
        for _ in 1...amountOfProductsNeeded{
            searchProduct()
            takeProduct()
        }
    }
    
    func waitPaydesk(){
        stateCustomer.WAIT_PAYDESK
    }
    
    func putOnBelt(){
        randomSleep()
        stateCustomer.PRODUCTS_OUT_CHART
    }
    
    func putInChart(){
        randomSleep()
        stateCustomer.PRODUCTS_IN_CHART
    }
    
    func hasPayed(){
        randomSleep()
        stateCustomer.PAYED
    }
    
    func dropChart(){
        randomSleep()
        stateCustomer.CHART_DROPPED
    }
    
    func leaveShop(){
        randomSleep()
        stateCustomer.LEFT_SHOP
    }
}