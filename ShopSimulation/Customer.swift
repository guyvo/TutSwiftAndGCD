//
//  Customer.swift
//  ShopSimulation
//
//  Created by Guy Van Overtveldt on 21/10/15.
//  Copyright © 2015 Guy Van Overtveldt. All rights reserved.
//

import Foundation

// momentums of a customer
enum stateCustomer : CustomStringConvertible{
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
    
    var description : String {
        switch self{
        case .ARRIVED : return "ARRIVED"
        case .ENTERED_SHOP : return "ENTERED_SHOP"
        case .CHART_TAKEN : return "CHART_TAKEN"
        case .IN_SEARCH : return "IN_SEARCH"
        case .PRODUCT_TAKEN : return "PRODUCT_TAKEN"
        case .WAIT_PAYDESK : return "WAIT_PAYDESK"
        case .PRODUCTS_OUT_CHART : return "PRODUCTS_OUT_CHART"
        case .PRODUCTS_IN_CHART : return "PRODUCTS_IN_CHART"
        case .PAYED : return "PAYED"
        case .CHART_DROPPED : return "CHART_DROPPED"
        case .LEFT_SHOP  : return "LEFT_SHOP"
        }
    }
}


class Customer{
    
    var id : Int
    let amountOfProductsNeeded : Int
    
    var state = stateCustomer.ARRIVED {
        willSet (value) {
            // notify here
            //print("customer_\(id) state \(state) will change into \(value)")
        }
        didSet{
            // notify here
            //print("customer_\(id) state changed into \(state)")
        }
    }
    
    init (id : Int,neededProducts : Int){
        amountOfProductsNeeded = neededProducts
        self.id = id
    }
    
    func getState() -> stateCustomer{
        return state
    }
    
    func drivetoShop(){
        state = stateCustomer.ARRIVED
        randomSleep()
    }
    
    func takeChart(){
        state = stateCustomer.ENTERED_SHOP
        randomSleep()
        state = stateCustomer.CHART_TAKEN
        randomSleep()
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


