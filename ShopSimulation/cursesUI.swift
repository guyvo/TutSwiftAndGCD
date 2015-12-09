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
    
    let sim = Simulation(amountOfCustomers: 1, maxProductsToBuy: 1)
    let shop = Shop(amountOfDesks: 10, deskCapacity: 20)
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
        init_pair(2,Int16(COLOR_BLACK),Int16(COLOR_BLUE));
        
        // Include function keys
        keypad(stdscr, true)
        
        // Optionals
        cbreak()
        noecho()
        intrflush(stdscr, true)

        // Setup update timer
        attr = dispatch_queue_attr_make_with_qos_class(DISPATCH_QUEUE_SERIAL, QOS_CLASS_USER_INTERACTIVE, 0)
        source = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_queue_create("com.gvo.timer", attr))
        dispatch_source_set_timer(source, dispatch_time(DISPATCH_TIME_NOW, 0), NSEC_PER_SEC / 100, 0)
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
                width = COLS
                heigth = LINES
                break
            case KEY_MIN:
                break
            default: true
                
            }
        }

    }
    
    func Update(){
        
    }
    
    func meter(var i : Int){
        addch(32)
        attron(COLOR_PAIR(2))
        while ( i-- > 0) {
            addch(32)
        }
        attroff(COLOR_PAIR(2))
    }
    
    func Render(){
        totals.calcTotals(sim.getCustomers())
        clear()
        //vline(0x221A, 10)
        //addstr("\u{221A}")
        attron(COLOR_PAIR(1))
        hline(50000,70);
        move(2,2)
        addstr(stateCustomer.ARRIVED.description + ": " + String(totals.totalArrived))
        meter(totals.totalArrived)
        attron(COLOR_PAIR(1))
        move(3,2)
        addstr(stateCustomer.ENTERED_SHOP.description + ": " + String(totals.totalEntered))
        meter(totals.totalEntered)
        attron(COLOR_PAIR(1))
        move(4,2)
        addstr(stateCustomer.CHART_TAKEN.description + ": " + String(totals.totalChartTaken))
        meter(totals.totalChartTaken)
        attron(COLOR_PAIR(1))
        move(5,2)
        addstr(stateCustomer.IN_SEARCH.description + ": " + String(totals.totalInSearch))
        meter(totals.totalInSearch)
        attron(COLOR_PAIR(1))
        move(6,2)
        addstr(stateCustomer.PRODUCT_TAKEN.description + ": " + String(totals.totalProductTaken))
        meter(totals.totalProductTaken)
        attron(COLOR_PAIR(1))
        move(7,2)
        addstr(stateCustomer.WAIT_PAYDESK.description + ": " + String(totals.totalWaitPaydesk))
        meter(totals.totalWaitPaydesk)
        attron(COLOR_PAIR(1))
        move(8,2)
        addstr(stateCustomer.PRODUCTS_OUT_CHART.description + ": " + String(totals.totalOutChart))
        meter(totals.totalOutChart)
        attron(COLOR_PAIR(1))
        move(9,2)
        addstr(stateCustomer.PRODUCTS_IN_CHART.description + ": " + String(totals.totalInChart))
        meter(totals.totalInChart)
        attron(COLOR_PAIR(1))
        move(10,2)
        addstr(stateCustomer.PAYED.description + ": " + String(totals.totalPayed))
        meter(totals.totalPayed)
        attron(COLOR_PAIR(1))
        move(11,2)
        addstr(stateCustomer.CHART_DROPPED.description + ": " + String(totals.totalCartDropped))
        meter(totals.totalCartDropped)
        attron(COLOR_PAIR(1))
        move(12,2)
        addstr(stateCustomer.LEFT_SHOP.description + ": " + String(totals.totalLeftShop))
        meter(totals.totalLeftShop)
        refresh()
        totals.zeroTotals()
    }

    func cleanUp(){
        dispatch_source_cancel(source)
        endwin()
        exit(0)
    }
}
