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

struct totalState{
    
    var totalArrived = 0
    var totalEntered = 0
    var totalChartTaken = 0
    var totalInSearch = 0
    var totalProductTaken = 0
    var totalWaitPaydesk = 0
    var totalOutChart = 0
    var totalInChart = 0
    var totalPayed = 0
    var totalCartDropped = 0
    var totalLeftShop = 0
    
    var totals = [stateCustomer:Int]()
    
    mutating func zeroTotals(){
        totalArrived = 0
        totalEntered = 0
        totalChartTaken = 0
        totalInSearch = 0
        totalProductTaken = 0
        totalWaitPaydesk = 0
        totalOutChart = 0
        totalInChart = 0
        totalPayed = 0
        totalCartDropped = 0
        totalLeftShop = 0
    }
    
    mutating func calcTotals (customers : [Customer]){
        for customer in customers{
            switch customer.state{
            case stateCustomer.ARRIVED:
                totalArrived++
                break
            case stateCustomer.ENTERED_SHOP:
                totalEntered++
                break
            case stateCustomer.CHART_TAKEN:
                totalChartTaken++
                break
            case stateCustomer.IN_SEARCH:
                totalInSearch++
                break
            case stateCustomer.PRODUCT_TAKEN:
                totalProductTaken++
                break
            case stateCustomer.WAIT_PAYDESK:
                totalWaitPaydesk++
            case stateCustomer.PRODUCTS_OUT_CHART:
                totalOutChart++
                break
            case stateCustomer.PRODUCTS_IN_CHART:
                totalInChart++
                break
            case stateCustomer.PAYED:
                totalPayed++
                break
            case stateCustomer.CHART_DROPPED:
                totalCartDropped++
                break
            case stateCustomer.LEFT_SHOP:
                totalLeftShop++
                break
            default:
                break
            }
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


