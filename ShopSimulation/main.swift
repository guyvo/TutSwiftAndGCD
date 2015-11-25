//
//  main.swift
//  ShopSimulation
//
//  Created by Guy Van Overtveldt on 21/10/15. f
//  Copyright © 2015 Guy Van Overtveldt. All rights reserved.
//
// Building of a shop simulation using swift classes and protocols
// GCD is used to simulate async and sync queues in shop
// The view is simple text based and uses ncurses terminal
//
// Swift version 2.1
// OSX 10.11
//
// Master
import Foundation

func test1(){
    // Warehouse creation not yet used
    let p1 = Food(kind: KindOfFood.FRUIT, price: 2.5)
    let p2 = NonFood(kind: KindOfNonFood.CLEANING, price : 15.2 )
    let pa : Array<Product> = [p1,p2]
    let w = Warehouse(products: pa)
    w.products = Array<Product>();
    
    // Simulation
    let sim = Simulation(amountOfCustomers: 2, maxProductsToBuy: 2)
    let shop = Shop(amountOfDesks: 4, deskCapacity: 20)
    shop.runShop(sim.getCustomers())


    
    // Wait until all threads in the group are finished
    dispatch_group_wait(shop.group, DISPATCH_TIME_FOREVER)
}

let window = cursesUI()
window.Input()
print("done")

