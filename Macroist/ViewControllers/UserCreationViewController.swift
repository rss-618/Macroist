//
//  ViewController.swift
//  ListBuilder
//
//  Created by Ryan Schildknecht on 1/15/21.
//

import UIKit

class UserCreationViewController: UIViewController {
    @IBOutlet weak var firstNameInput       : UITextField!
    @IBOutlet weak var lastNameInput        : UITextField!
    @IBOutlet weak var ageInput             : UITextField!
    @IBOutlet weak var createProfileButton   : UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.hideKeyboardWhenTappedAround()
        configureButton()
        configureFields()
    }

    func configureFields(){
        if UserDefaults.standard.object(forKey: .USER_KEY) != nil{
            let storedObject: Data = UserDefaults.standard.object(forKey: .USER_KEY) as! Data
            let user: User = try! PropertyListDecoder().decode(User.self, from: storedObject)
            firstNameInput.text = user.getFirst()
            lastNameInput.text = user.getLast()
            ageInput.text = String(user.getAge())
        }
    }

    func configureButton(){
        createProfileButton.layer.cornerRadius = Constant.CORNER_RADIUS
        createProfileButton.layer.shadowColor = #colorLiteral(red: 0.05560452491, green: 0.05528203398, blue: 0.05585758388, alpha: 1)
        createProfileButton.layer.shadowRadius = Constant.SHADOW_RADIUS
        createProfileButton.layer.shadowOffset = CGSize(width: Constant.SHADOW_OFFSET_X, height: Constant.SHADOW_OFFSET_Y)
        createProfileButton.layer.shadowOpacity = Constant.SHADOW_OPACITY
    }
    
    @IBAction func addButton(_ sender: Any) {
        if !firstNameInput.text!.isEmpty && !lastNameInput.text!.isEmpty{
            if let age = Int(ageInput.text!) {
                let user: User = User(first: firstNameInput.text!, last: lastNameInput.text!, age: age)
                UserDefaults.standard.set(try! PropertyListEncoder().encode(user), forKey: .USER_KEY)
                /*
                 To decode/access you need to 'let storedObject: Data = UserDefaults.standard.object(forKey: kPlayerDefaultsKey) as! Data
                let storedPlayer: Player = try! PropertyListDecoder().decode(Player.self, from: storedObject)'
                 */
                redirectToMain()
                return
            }
        }
        let alert = UIAlertController(title: .DEFAULT_ERROR_TITLE, message: .MISSING_INPUT, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: .OKAY, style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func redirectToMain(){
        navigationController?.popViewController(animated: false)
        dismiss(animated: false, completion: nil)
    }
}

