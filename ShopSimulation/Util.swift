//
//  Util.swift
//  ShopSimulation
//
//  Created by Guy Van Overtveldt on 21/11/15.
//  Copyright © 2015 Guy Van Overtveldt. All rights reserved.
//

import Foundation

// default of x seconds as maxmimum
func randomSleep (maximum : UInt32 = 10) -> UInt32 {
    
    let time = UInt32(arc4random()) % maximum;sleep(time)
    return time
}
