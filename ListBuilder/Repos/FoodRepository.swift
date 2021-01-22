//
//  FoodRepository.swift
//  ListBuilder
//
//  Created by Ryan Schildknecht on 1/21/21.
//

import SwiftUI
import CoreData

class FoodRepo {

    static func saveFoodItem(food: Food) -> Bool{
        // Store Into persistant info
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let foodItem = NSEntityDescription.insertNewObject(forEntityName: "Food", into: context)
        foodItem.setValue(Helper.getCurrentDate(), forKey:"date")
        foodItem.setValue(food.name, forKey: "name")
        foodItem.setValue(food.calories, forKey: "calories")
        foodItem.setValue(food.protein, forKey: "protein")
        foodItem.setValue(food.carbs, forKey: "carbs")
        foodItem.setValue(food.fat, forKey: "fat")

        do {
            try context.save()
            return true
        } catch {
            print("error saving")
            return false
        }
    }

    static func retrieveSavedFood() -> [Food]? {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Food")
        let context = appDelegate.persistentContainer.viewContext
        request.returnsObjectsAsFaults = false
        var retrievedFood: [Food] = []
        do {
            let results = try context.fetch(request)
            if !results.isEmpty {
                for result in results as! [NSManagedObject] {
                    guard let name = result.value(forKey: "name") as? String else { return nil }
                    guard let date = result.value(forKey: "date") as? String else { return nil }
                    guard let calories = result.value(forKey: "calories") as? Double else { return nil }
                    guard let protein = result.value(forKey: "protein") as? Double else { return nil }
                    guard let carbs = result.value(forKey: "carbs") as? Double else { return nil }
                    guard let fat = result.value(forKey: "fat") as? Double else { return nil }
                    let foodItem = Food(name: name,
                                        date: date,
                                        calories: calories,
                                        protein: protein,
                                        carbs: carbs,
                                        fat: fat)
                    retrievedFood.append(foodItem)
                }
            }
        } catch {
            print("Error retrieving: \(error)")
        }
        return retrievedFood
    }
    
    //Figure out way to delete
    static func deleteAllFoodRecords(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
//        let foodItem = NSEntityDescription.insertNewObject(forEntityName: "Food", into: context)
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Food")

        // Configure Fetch Request
        fetchRequest.includesPropertyValues = false

        do {
            let items = try context.fetch(fetchRequest) as! [NSManagedObject]

            for item in items {
                context.delete(item)
            }

            // Save Changes
            try context.save()

        } catch {
            // Error Handling
            // ...
        }
    }
}

