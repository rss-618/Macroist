//
//  MainViewController.swift
//  ListBuilder
//
//  Created by Ryan Schildknecht on 1/19/21.
//

import UIKit

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var calenderIcon     : UILabel!
    @IBOutlet weak var profileIcon      : UIImageView!
    @IBOutlet weak var addMealButton    : UIButton!
    @IBOutlet weak var tableView        : UITableView!
    @IBOutlet weak var totalCalories    : UILabel!
    @IBOutlet weak var totalProtein     : UILabel!
    @IBOutlet weak var totalCarbs       : UILabel!
    @IBOutlet weak var totalFat         : UILabel!
    
    var foodItems    : [Food] = []
    var dailySum     : Food = Food()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.hideKeyboardWhenTappedAround()
        self.tableView.register(UINib(nibName: "foodItem", bundle: nil), forCellReuseIdentifier: "FoodItem")
               self.tableView.dataSource = self
               self.tableView.delegate   = self
        configureButton()
        addClickListeners()
        getFoodItems()
    }
    override func viewWillAppear(_ animate: Bool){
        //For updating table data
        super.viewWillAppear(false)
        getFoodItems()
    }
    
    func addFoodItem(food: Food){
        foodItems.append(food)
        calcAndUpdateNutritionSum()
    }
    func getFoodItems(){
        foodItems = FoodRepo.retrieveSavedFood()!
        tableView.reloadData()
        calcAndUpdateNutritionSum()
    }
    func addClickListeners(){
        profileIcon.isUserInteractionEnabled = true
        profileIcon.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(redirectToProfileEditor)))
    }
    
    func configureButton(){
        addMealButton.layer.cornerRadius = Constant.CORNER_RADIUS
        addMealButton.layer.shadowColor = #colorLiteral(red: 0.05560452491, green: 0.05528203398, blue: 0.05585758388, alpha: 1)
        addMealButton.layer.shadowRadius = Constant.SHADOW_RADIUS
        addMealButton.layer.shadowOffset = CGSize(width: Constant.SHADOW_OFFSET_X, height: Constant.SHADOW_OFFSET_Y)
        addMealButton.layer.shadowOpacity = Constant.SHADOW_OPACITY
    }
    
    func calcAndUpdateNutritionSum(){
        dailySum = Food()
        for food in foodItems{
            dailySum.calories += food.calories
            dailySum.protein  += food.protein
            dailySum.carbs    += food.carbs
            dailySum.fat      += food.fat
        }
        totalCalories.text  = String(format: .CALORIE_FORMAT, dailySum.calories)
        totalProtein.text   = String(format: .GRAM_FORMAT, dailySum.protein)
        totalCarbs.text     = String(format: .GRAM_FORMAT, dailySum.carbs)
        totalFat.text       = String(format: .GRAM_FORMAT, dailySum.fat)
        
    }
    // Maybe make an acutal profile page then make that be able to display info then
    @objc func redirectToProfileEditor(){
        self.performSegue(withIdentifier: "mainToProfile", sender: self)
    }
    
    //MARK:- UITableView DataSource & Delegate
      func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        calcAndUpdateNutritionSum()
          return self.foodItems.count
      }

      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "FoodItem") as! FoodCell

        // allocate data to cell
        cell.foodTitle.text     = String(foodItems[indexPath.row].name)
        cell.caloriesText.text  = String(format: .CALORIE_FORMAT, foodItems[indexPath.row].calories)
        cell.proteinText.text   = String(format: .GRAM_FORMAT, foodItems[indexPath.row].protein)
        cell.carbsText.text     = String(format: .GRAM_FORMAT, foodItems[indexPath.row].carbs)
        cell.fatText.text       = String(format: .GRAM_FORMAT, foodItems[indexPath.row].fat)

        return cell
      }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath)
            -> UISwipeActionsConfiguration? {
            let deleteAction = UIContextualAction(style: .destructive, title: nil) { (_, _, completionHandler) in
            // delete the item here
                if !FoodRepo.deleteFood(food: self.foodItems[indexPath.row])!{
                    let alert = UIAlertController(title: .ERROR_DELETING, message: nil, preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: .OKAY, style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
                self.foodItems.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
                completionHandler(true)
        }
        let cgImageX =  UIImage(systemName: "trash")?.cgImage
        deleteAction.image = OriginalImageRender(cgImage: cgImageX!)
        deleteAction.backgroundColor = UIColor.init(red: .zero, green: .zero, blue: .zero, alpha: .zero)
        return UISwipeActionsConfiguration.init(actions: [deleteAction])
    }
      
}
