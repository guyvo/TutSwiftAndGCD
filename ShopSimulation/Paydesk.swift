//
//  Paydesk.swift
//  ShopSimulation
//
//  Created by Guy Van Overtveldt on 21/10/15.
//  Copyright © 2015 Guy Van Overtveldt. All rights reserved.
//

import Foundation

class PayDesk{
    
    let queue : dispatch_queue_t
    let capacity : dispatch_semaphore_t
    let name : String
    
    init (name : String , maximum : Int){
        queue = dispatch_queue_create(name, DISPATCH_QUEUE_SERIAL)
        capacity = dispatch_semaphore_create(maximum)
        self.name = name
    }
    
    func addCustomer (customer : Customer){
        print(" customer_\(customer.id) is waiting on paydesk \(name)")
        dispatch_semaphore_wait(capacity, DISPATCH_TIME_FOREVER)
        dispatch_sync(queue, {
            customer.putOnBelt()
            customer.putInChart()
            customer.hasPayed()
            dispatch_semaphore_signal(self.capacity)
        })
    }
}