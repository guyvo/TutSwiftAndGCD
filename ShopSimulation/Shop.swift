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