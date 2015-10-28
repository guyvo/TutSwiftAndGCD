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
// Swift version 2
// OSX 10.11

import Foundation
import Darwin.ncurses

// default of x seconds as maxmimum
func randomSleep (maximum : UInt32 = 2) -> UInt32 {
    
    let time = UInt32(arc4random()) % maximum
    sleep(time)
    return time
}

// for later use
func useUI() {
    // using environment variables of the system
    setlocale(LC_ALL,"")
    
    // Initialize ncurses
    initscr()
    cbreak()
    noecho()
    nonl()
    intrflush(stdscr,true)
    keypad(stdscr,true)
    curs_set(0)
    
    // stay in the program until ESC is pressed
    while true {
        
        switch getch(){
        case 27:
            endwin()
            exit(EX_OK)
        default: true
        }
        
    }
}

//let t = randomSleep()
let p1 = Food(kind: KindOfFood.FRUIT, price: 2.5)
let p2 = NonFood(kind: KindOfNonFood.CLEANING, price : 15.2 )
let pa : Array<Product> = [p1,p2]
let w = Warehouse(products: pa)

let sim = Simulation(maxProductsToBuy: 20)
let customers = sim.createCustomers(50)
let shop = Shop(amountOfDesks: 4, deskCapacity: 20)

shop.runShop(customers)
dispatch_group_wait(shop.group, DISPATCH_TIME_FOREVER)

print("done")

