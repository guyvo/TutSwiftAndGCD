//
//  cursesUI.swift
//  ShopSimulation
//
//  Created by Guy Van Overtveldt on 21/11/15.
//  Copyright © 2015 Guy Van Overtveldt. All rights reserved.
//
// The only file that depends on ncurses module

import Foundation
import Darwin.ncurses

// Terminal UI implements protocol UI
class cursesUI : UI{
    
    private var attr: dispatch_queue_attr_t
    private var source: dispatch_source_t
    
    private var width: Int32
    private var heigth: Int32
    
    // Not in ncurses lib
    private let KEY_ESC: Int32 = 27
    
    var temp = 1001
    
    let sim = Simulation(amountOfCustomers: 50, maxProductsToBuy: 10)
    let shop = Shop(amountOfDesks: 6, deskCapacity: 10)
    var totals = totalState()
    
    required init (){
        
        // Using environment variables of the system
        setlocale(LC_ALL,"")
        
        // Initialize curses window
        initscr()
        width = COLS
        heigth = LINES
        curs_set(0)

        // Color setup
        start_color()
        init_pair(1,Int16(COLOR_GREEN),Int16(COLOR_BLACK));
        
        // Include function keys
        keypad(stdscr, true)
        
        // Optionals
        cbreak()
        noecho()
        intrflush(stdscr, true)

        // Setup update timer
        attr = dispatch_queue_attr_make_with_qos_class(DISPATCH_QUEUE_SERIAL, QOS_CLASS_USER_INTERACTIVE, 0)
        source = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_queue_create("com.gvo.timer", attr))
        dispatch_source_set_timer(source, dispatch_time(DISPATCH_TIME_NOW, 0), NSEC_PER_SEC / 10, 0)
        dispatch_source_set_event_handler(source) {
            self.Render()
        }
        
        // We have to resume the dispatch source as it is paused by default
        dispatch_resume(source)
    }
    
    func Input(){
        
        
        while true {
            switch getch(){
            case KEY_ENTER:
                // start simulation
                break
            case KEY_UP:
                shop.runShop(sim.getCustomers())
                break
            case KEY_DOWN:
                break
            case KEY_ESC:
                cleanUp()
                break
            case KEY_RESIZE:
                width = COLS
                heigth = LINES
                break
            case KEY_MAX:
                break
            case KEY_MIN:
                break
            default: true
                
            }
        }

    }
    
    func Update(){
        
    }
    
    func Render(){
        totals.calcTotals(sim.getCustomers())
        clear()
        attron(COLOR_PAIR(1))
        move(2,2)
        addstr(stateCustomer.ARRIVED.description + ": " + String(totals.totalArrived))
        move(3,2)
        addstr(stateCustomer.ENTERED_SHOP.description + ": " + String(totals.totalEntered))
        move(4,2)
        addstr(stateCustomer.CHART_TAKEN.description + ": " + String(totals.totalChartTaken))
        move(5,2)
        addstr(stateCustomer.IN_SEARCH.description + ": " + String(totals.totalInSearch))
        move(6,2)
        addstr(stateCustomer.PRODUCT_TAKEN.description + ": " + String(totals.totalProductTaken))
        move(7,2)
        addstr(stateCustomer.WAIT_PAYDESK.description + ": " + String(totals.totalWaitPaydesk))
        move(8,2)
        addstr(stateCustomer.PRODUCTS_OUT_CHART.description + ": " + String(totals.totalOutChart))
        move(9,2)
        addstr(stateCustomer.PRODUCTS_IN_CHART.description + ": " + String(totals.totalInChart))
        move(10,2)
        addstr(stateCustomer.PAYED.description + ": " + String(totals.totalPayed))
        move(11,2)
        addstr(stateCustomer.CHART_DROPPED.description + ": " + String(totals.totalCartDropped))
        move(12,2)
        addstr(stateCustomer.LEFT_SHOP.description + ": " + String(totals.totalLeftShop))
        attroff(COLOR_PAIR(1))
        refresh()
        totals.zeroTotals()
    }

    func cleanUp(){
        dispatch_source_cancel(source)
        endwin()
        exit(0)
    }
}
