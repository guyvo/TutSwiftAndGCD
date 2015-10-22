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

// default of 10 seconds as maxmimum
func randomSleep (maximum : UInt32 = 10) -> UInt32 {
    
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

let t = randomSleep()
print("done in \(t) seconds")

