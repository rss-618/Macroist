//
//  User.swift
//  ListBuilder
//
//  Created by Ryan Schildknecht on 1/19/21.
//

import Foundation

class User: Codable {
    
    private var firstName: String
    private var lastName: String
    private var age: Int
    
    init(first: String, last: String , age: Int) {
        self.firstName = first
        self.lastName = last
        self.age = age
    }
    
    func getFirst() -> String{
        return firstName
    }
    
    func getLast() -> String{
        return lastName
    }
    
    func getAge() -> Int{
        return age
    }
    
    func setFirst(_ first: String){
        self.firstName = first
    }
    
    func setLast(_ last: String){
        self.lastName = last
    }
    
    func setAge(_ age: Int){
        self.age = age
    }
    
}
