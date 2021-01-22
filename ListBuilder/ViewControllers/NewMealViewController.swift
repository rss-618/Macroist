//
//  NewMealViewController.swift
//  ListBuilder
//
//  Created by Ryan Schildknecht on 1/21/21.
//

import SwiftUI
import CoreData

class NewMealViewController: UIViewController{
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var foodNameInput: UITextField!
    @IBOutlet weak var caloriesInput: UITextField!
    @IBOutlet weak var proteinInput: UITextField!
    @IBOutlet weak var carbsInput: UITextField!
    @IBOutlet weak var fatInput: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureButtons()
        self.hideKeyboardWhenTappedAround()
        for food in FoodRepo.retrieveSavedFood()!{
            print(food.toString())
        }
        
    }
    
    func configureButtons(){
        cancelButton.layer.cornerRadius = Constant.CORNER_RADIUS
        cancelButton.layer.shadowColor = #colorLiteral(red: 0.05560452491, green: 0.05528203398, blue: 0.05585758388, alpha: 1)
        cancelButton.layer.shadowRadius = Constant.SHADOW_RADIUS
        cancelButton.layer.shadowOffset = CGSize(width: Constant.SHADOW_OFFSET_X, height: Constant.SHADOW_OFFSET_Y)
        cancelButton.layer.shadowOpacity = Constant.SHADOW_OPACITY
        
        doneButton.layer.cornerRadius = Constant.CORNER_RADIUS
        doneButton.layer.shadowColor = #colorLiteral(red: 0.05560452491, green: 0.05528203398, blue: 0.05585758388, alpha: 1)
        doneButton.layer.shadowRadius = Constant.SHADOW_RADIUS
        doneButton.layer.shadowOffset = CGSize(width: Constant.SHADOW_OFFSET_X, height: Constant.SHADOW_OFFSET_Y)
        doneButton.layer.shadowOpacity = Constant.SHADOW_OPACITY
    }
    @IBAction func cancelPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func donePressed(_ sender: Any) {
        // Store Into persistant info
        let name = foodNameInput.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if name != .EMPTY{
            let calories = Double(caloriesInput.text!) ?? 0.0
            let protein = Double(proteinInput.text!) ?? 0.0
            let carbs = Double(carbsInput.text!) ?? 0.0
            let fat = Double(fatInput.text!) ?? 0.0
            let food:Food = Food(name: name,
                                 calories: calories,
                                 protein: protein,
                                 carbs: carbs,
                                 fat: fat)
            let result = FoodRepo.saveFoodItem(food: food)
            if result == true{
                navigationController?.popViewController(animated: true)
                dismiss(animated: true, completion: nil)
            }
        }
        else{
            let alert = UIAlertController(title: .MISSING_NAME, message: nil, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: .OKAY, style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
}
