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
    
    init (name : String , maximum : Int){
        queue = dispatch_queue_create(name, DISPATCH_QUEUE_SERIAL)
        capacity = dispatch_semaphore_create(maximum)
    }
    
    func addCustomer (customer : Customer){
        dispatch_semaphore_wait(capacity, DISPATCH_TIME_FOREVER)
        dispatch_async(queue, {
            
            // TODO change state of customer here
            randomSleep(10)
            dispatch_semaphore_signal(self.capacity)
        })
    }
}