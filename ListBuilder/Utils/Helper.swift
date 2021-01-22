//
//  UtilFunctions.swift
//  ListBuilder
//
//  Created by Ryan Schildknecht on 1/21/21.
//

import Foundation

class Helper{
    
    //Gets current date
    static func getCurrentDate() -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = .DATE_FORMAT
        return formatter.string(from: Date())
    }
}
