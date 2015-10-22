//
//  Product.swift
//  ShopSimulation
//
//  Created by Guy Van Overtveldt on 22/10/15.
//  Copyright © 2015 Guy Van Overtveldt. All rights reserved.
//

import Foundation

enum KindOfFood{
    case
    VEGETABLE,
    MEAT,
    FRUIT
}

enum KindOfNonFood{
    case
    CLEANING,
    TOOLS,
    MAGAZINES
}

// undefined product but every one has a price
class Product{
    
    var price : Float
    
    init ( price : Float) {
        self.price = price
    }
}

// specific product
class Food : Product {

    let kind : KindOfFood
    
    init ( kind : KindOfFood , price : Float){
        self.kind = kind
        super.init(price: price)
    }
}

// specific product
class NonFood : Product {
    
    let kind : KindOfNonFood
    
    init ( kind : KindOfNonFood , price : Float){
        self.kind = kind
        super.init(price: price)
    }
}
