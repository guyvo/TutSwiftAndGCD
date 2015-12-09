//
//  Shop.swift
//  ShopSimulation
//
//  Created by Guy Van Overtveldt on 21/10/15.
//  Copyright © 2015 Guy Van Overtveldt. All rights reserved.
//
// new
// class

import Foundation

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

class Shop {
    
    var paydesks = [PayDesk]()
    
    static let attr = dispatch_queue_attr_make_with_qos_class(DISPATCH_QUEUE_CONCURRENT,QOS_CLASS_USER_INITIATED ,-1)
    let queue = dispatch_queue_create("customers", attr)
    let group = dispatch_group_create()
    
    init(amountOfDesks : Int, deskCapacity : Int){
        
        for desk in 1...amountOfDesks{
            paydesks.append(PayDesk(name: "desk_\(desk)" , maximum: deskCapacity))
        }
    }
    
    func runShop(customers : [Customer]){
            for customer in customers{
                dispatch_group_async(group , queue, {
                    customer.drivetoShop()
                    customer.takeChart()
                    customer.buyProducts()
                    customer.waitPaydesk()
                    self.paydesks[Int(arc4random()) % self.paydesks.count].addCustomer(customer)
                    customer.dropChart()
                    customer.leaveShop()
                })
            }
    }
}