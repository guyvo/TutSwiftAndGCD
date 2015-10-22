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
//
// Master


import Foundation
import Darwin.ncurses

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