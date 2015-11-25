//
//  UI.swift
//  ShopSimulation
//
//  Created by Guy Van Overtveldt on 21/11/15.
//  Copyright © 2015 Guy Van Overtveldt. All rights reserved.
//

import Foundation

protocol UI{
  
    init()
    func Input()
    func Update()
    func Render()
    func cleanUp()
}
