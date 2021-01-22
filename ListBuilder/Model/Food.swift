//
//  Food.swift
//  ListBuilder
//
//  Created by Ryan Schildknecht on 1/20/21.
//

import Foundation
//Make NSMANAGEDOBJECT or find another way for delete functionality
class Food: Codable{
    public var name         : String = ""
    public var calories     : Double = 0.0
    public var protein      : Double = 0.0
    public var carbs        : Double = 0.0
    public var fat          : Double = 0.0
    
    init() {}
    init(name: String, calories: Double, protein: Double, carbs: Double, fat: Double) {
        self.name       = name
        self.calories   = calories
        self.protein    = protein
        self.carbs      = carbs
        self.fat        = fat
    }
    
    func toString() -> String{
        return String(format: "%@: %d calories, %d protein, %d carbs, %d fat", name, calories, protein, carbs, fat)
    }
    
}
